import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/slidex_config.dart';
import '../core/slidex_controller.dart';
import '../core/slidex_enums.dart';
import '../effects/slidex_effect.dart';
import '../gestures/gesture_engine.dart';
import '../physics/snap_physics.dart';
import 'slidex_engine.dart';

/// Primary view renderer for SlideX.
class SlideXView extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final SlideXConfig config;
  final SlideXEffect effect;
  final SlideXController controller;
  final ValueChanged<int>? onPageChanged;
  final Widget? indicator;
  final Alignment indicatorAlignment;

  const SlideXView({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    required this.config,
    required this.effect,
    required this.controller,
    this.onPageChanged,
    this.indicator,
    this.indicatorAlignment = Alignment.bottomCenter,
  });

  @override
  State<SlideXView> createState() => _SlideXViewState();
}

class _SlideXViewState extends State<SlideXView> {
  late PageController _pageController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _pageController = PageController(
      initialPage: widget.controller.currentPage,
      viewportFraction: widget.config.viewportFraction,
    );

    widget.controller.attach(
      pageController: _pageController,
      itemCount: widget.itemCount,
      config: widget.config,
    );

    _pageController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.hasClients && _pageController.page != null) {
      final page = _pageController.page!;
      widget.controller.updatePageOffset(page, page.round() % widget.itemCount);
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onScroll);
    _pageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (!widget.config.enableKeyboard || event is! KeyDownEvent) return;

    if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      widget.controller.nextPage();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      widget.controller.previousPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 0) return const SizedBox.shrink();

    final isHorizontal = widget.config.scrollDirection == SlideXAxis.horizontal;

    Widget body = AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final currentOffset = widget.controller.pageOffset;

        return PageView.builder(
          controller: _pageController,
          allowImplicitScrolling: true,
          scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
          physics: widget.config.enableGestures
              ? const SlideXSnapPhysics()
              : const NeverScrollableScrollPhysics(),
          itemCount: widget.itemCount,
          onPageChanged: (index) {
            widget.onPageChanged?.call(index);
          },
          itemBuilder: (context, index) {
            final position = SlideXEngine.calculatePosition(
              index: index,
              pageOffset: currentOffset,
              itemCount: widget.itemCount,
              isLooping: widget.config.loopMode == SlideXLoopMode.infinite,
            );

            final childWidget = widget.itemBuilder(context, index);

            return SlideXEngine.applyEffect(
              context: context,
              child: childWidget,
              position: position,
              effect: widget.effect,
              config: widget.config,
            );
          },
        );
      },
    );

    if (widget.config.enableGestures) {
      body = SlideXGestureEngine(
        controller: widget.controller,
        child: body,
      );
    }

    if (widget.config.enableKeyboard) {
      body = KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: _handleKeyEvent,
        child: body,
      );
    }

    if (widget.config.pauseOnHover) {
      body = MouseRegion(
        onEnter: (_) => widget.controller.stopAutoPlay(),
        onExit: (_) {
          if (widget.config.autoPlay) {
            widget.controller.startAutoPlay();
          }
        },
        child: body,
      );
    }

    return ClipRect(
      clipBehavior: widget.config.clipBehavior,
      child: Stack(
        alignment: Alignment.center,
        children: [
          body,
          if (widget.indicator != null)
            Positioned.fill(
              child: Align(
                alignment: widget.indicatorAlignment,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: widget.indicator,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
