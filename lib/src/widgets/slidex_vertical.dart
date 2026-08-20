import 'package:flutter/material.dart';

import '../core/slidex_config.dart';
import '../core/slidex_controller.dart';
import '../core/slidex_enums.dart';
import '../effects/2d/slidex_2d_effects.dart';
import '../effects/slidex_effect.dart';
import 'slidex_main.dart';

/// Dedicated Vertical Axis Slider Widget for SlideX with 100% Granular User Controls.
class SlideXVertical extends StatefulWidget {
  final List<Widget> items;
  final double height;
  final double viewportFraction;
  final SlideXEffect effect;
  final SlideXIndicatorType indicatorType;
  final Color indicatorActiveColor;
  final Color indicatorInactiveColor;
  final Alignment indicatorAlignment;
  final bool showControls;
  final Color upControlColor;
  final Color downControlColor;
  final Color controlsBackgroundColor;
  final SlideXController? controller;
  final ValueChanged<int>? onPageChanged;

  const SlideXVertical({
    super.key,
    required this.items,
    this.height = 420.0,
    this.viewportFraction = 0.85,
    this.effect = const SlideEffect(),
    this.indicatorType = SlideXIndicatorType.expandingDot,
    this.indicatorActiveColor = const Color(0xFF6366F1),
    this.indicatorInactiveColor = const Color(0x4DFFFFFF),
    this.indicatorAlignment = Alignment.centerRight,
    this.showControls = true,
    this.upControlColor = const Color(0xFF6366F1),
    this.downControlColor = const Color(0xFFEC4899),
    this.controlsBackgroundColor = const Color(0x99000000),
    this.controller,
    this.onPageChanged,
  });

  @override
  State<SlideXVertical> createState() => _SlideXVerticalState();
}

class _SlideXVerticalState extends State<SlideXVertical> {
  late SlideXController _internalController;

  SlideXController get _activeController =>
      widget.controller ?? _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = SlideXController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Vertical SlideX Pager
          SlideX(
            controller: _activeController,
            config: SlideXConfig(
              scrollDirection: SlideXAxis.vertical,
              viewportFraction: widget.viewportFraction,
              loopMode: SlideXLoopMode.infinite,
            ),
            effect: widget.effect,
            indicatorType: widget.indicatorType,
            indicatorAlignment: widget.indicatorAlignment,
            indicatorActiveColor: widget.indicatorActiveColor,
            indicatorInactiveColor: widget.indicatorInactiveColor,
            onPageChanged: widget.onPageChanged,
            items: widget.items,
          ),

          // Vertical Chevrons (Top Up Arrow & Bottom Down Arrow)
          if (widget.showControls)
            Positioned(
              right: 16,
              top: 16,
              bottom: 16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton.filled(
                    onPressed: () => _activeController.previousPage(),
                    icon: const Icon(Icons.keyboard_arrow_up, size: 22),
                    style: IconButton.styleFrom(
                      backgroundColor: widget.controlsBackgroundColor,
                      foregroundColor: widget.upControlColor,
                      side: BorderSide(
                        color: widget.upControlColor.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                  IconButton.filled(
                    onPressed: () => _activeController.nextPage(),
                    icon: const Icon(Icons.keyboard_arrow_down, size: 22),
                    style: IconButton.styleFrom(
                      backgroundColor: widget.controlsBackgroundColor,
                      foregroundColor: widget.downControlColor,
                      side: BorderSide(
                        color: widget.downControlColor.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
