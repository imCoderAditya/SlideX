import 'package:flutter/material.dart';

import '../core/slidex_config.dart';
import '../core/slidex_controller.dart';
import '../effects/2d/slidex_2d_effects.dart';
import '../effects/slidex_effect.dart';
import '../engine/slidex_view.dart';

/// Position of the thumbnail strip in [SlideXGalleryView].
enum SlideXThumbnailPosition { bottom, top }

/// Feature-rich E-Commerce & Media Gallery Widget for SlideX with 100% Granular User Controls.
class SlideXGalleryView extends StatefulWidget {
  final List<Widget> items;
  final List<Widget>? thumbnails;
  final double thumbnailHeight;
  final SlideXEffect effect;
  final SlideXThumbnailPosition thumbnailPosition;
  final bool enableFullscreenZoom;
  final bool showBadge;
  final ValueChanged<int>? onIndexChanged;
  final Color activeBorderColor;
  final Color inactiveBorderColor;
  final double activeBorderWidth;
  final Color badgeBackgroundColor;
  final TextStyle? badgeTextStyle;
  final IconData fullscreenIcon;
  final Color fullscreenIconColor;
  final Color fullscreenIconBackgroundColor;
  final double thumbnailSpacing;
  final BorderRadius thumbnailBorderRadius;
  final BorderRadius galleryBorderRadius;

  const SlideXGalleryView({
    super.key,
    required this.items,
    this.thumbnails,
    this.thumbnailHeight = 72.0,
    this.effect = const ScaleEffect(),
    this.thumbnailPosition = SlideXThumbnailPosition.bottom,
    this.enableFullscreenZoom = true,
    this.showBadge = true,
    this.onIndexChanged,
    this.activeBorderColor = const Color(0xFF6366F1),
    this.inactiveBorderColor = Colors.transparent,
    this.activeBorderWidth = 2.5,
    this.badgeBackgroundColor = const Color(0x99000000),
    this.badgeTextStyle,
    this.fullscreenIcon = Icons.fullscreen,
    this.fullscreenIconColor = Colors.white,
    this.fullscreenIconBackgroundColor = const Color(0x99000000),
    this.thumbnailSpacing = 8.0,
    this.thumbnailBorderRadius = const BorderRadius.all(Radius.circular(12)),
    this.galleryBorderRadius = const BorderRadius.all(Radius.circular(20)),
  });

  @override
  State<SlideXGalleryView> createState() => _SlideXGalleryViewState();
}

class _SlideXGalleryViewState extends State<SlideXGalleryView> {
  late SlideXController _controller;
  late ScrollController _thumbnailScrollController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = SlideXController();
    _thumbnailScrollController = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _thumbnailScrollController.dispose();
    super.dispose();
  }

  void _onThumbnailTap(int index) {
    setState(() => _selectedIndex = index);
    _controller.animateToPage(index);
    widget.onIndexChanged?.call(index);
    _scrollToThumbnail(index);
  }

  void _scrollToThumbnail(int index) {
    if (!_thumbnailScrollController.hasClients) return;
    final itemWidth = widget.thumbnailHeight + widget.thumbnailSpacing;
    final targetOffset = (index * itemWidth) - (itemWidth * 1.5);
    _thumbnailScrollController.animateTo(
      targetOffset.clamp(
        0.0,
        _thumbnailScrollController.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _openFullscreenLightbox(BuildContext context, int initialIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            _LightboxScreen(items: widget.items, initialIndex: initialIndex),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();

    final thumbnailList = widget.thumbnails ?? widget.items;

    // Thumbnail Navigation Strip
    final thumbnailStrip = SizedBox(
      height: widget.thumbnailHeight,
      child: ListView.builder(
        controller: _thumbnailScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: thumbnailList.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedIndex;
          return GestureDetector(
            onTap: () => _onThumbnailTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(right: widget.thumbnailSpacing),
              width: widget.thumbnailHeight,
              height: widget.thumbnailHeight,
              decoration: BoxDecoration(
                borderRadius: widget.thumbnailBorderRadius,
                border: Border.all(
                  color: isSelected
                      ? widget.activeBorderColor
                      : widget.inactiveBorderColor,
                  width: isSelected ? widget.activeBorderWidth : 1.0,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: widget.activeBorderColor.withValues(
                            alpha: 0.4,
                          ),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: ClipRRect(
                borderRadius: widget.thumbnailBorderRadius,
                child: thumbnailList[index],
              ),
            ),
          );
        },
      ),
    );

    // Main Interactive Gallery Viewport
    final mainViewport = Expanded(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: widget.galleryBorderRadius,
            child: SlideXView(
              itemBuilder: (context, index) => widget.items[index],
              itemCount: widget.items.length,
              config: const SlideXConfig(viewportFraction: 1.0),
              effect: widget.effect,
              controller: _controller,
              onPageChanged: (index) {
                setState(() => _selectedIndex = index);
                widget.onIndexChanged?.call(index);
                _scrollToThumbnail(index);
              },
            ),
          ),

          // Top Header Overlay Badge & Fullscreen Icon
          if (widget.showBadge || widget.enableFullscreenZoom)
            Positioned(
              top: 12,
              right: 12,
              child: Row(
                children: [
                  if (widget.showBadge)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: widget.badgeBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_selectedIndex + 1} / ${widget.items.length}',
                        style:
                            widget.badgeTextStyle ??
                            const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  if (widget.enableFullscreenZoom) ...[
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () =>
                          _openFullscreenLightbox(context, _selectedIndex),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: widget.fullscreenIconBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          widget.fullscreenIcon,
                          color: widget.fullscreenIconColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );

    return Column(
      children: [
        if (widget.thumbnailPosition == SlideXThumbnailPosition.top) ...[
          thumbnailStrip,
          const SizedBox(height: 12),
        ],
        mainViewport,
        if (widget.thumbnailPosition == SlideXThumbnailPosition.bottom) ...[
          const SizedBox(height: 12),
          thumbnailStrip,
        ],
      ],
    );
  }
}

class _LightboxScreen extends StatelessWidget {
  final List<Widget> items;
  final int initialIndex;

  const _LightboxScreen({required this.items, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    final controller = SlideXController();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          InteractiveViewer(
            minScale: 0.8,
            maxScale: 4.0,
            child: SlideXView(
              itemBuilder: (context, index) => items[index],
              itemCount: items.length,
              config: const SlideXConfig(viewportFraction: 1.0),
              effect: const ScaleEffect(),
              controller: controller,
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
