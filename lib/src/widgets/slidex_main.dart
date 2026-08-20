import 'package:flutter/material.dart';

import '../core/slidex_config.dart';
import '../core/slidex_controller.dart';
import '../core/slidex_enums.dart';
import '../effects/2d/slidex_2d_effects.dart';
import '../effects/3d/slidex_3d_effects.dart';
import '../effects/slidex_effect.dart';
import '../engine/slidex_view.dart';
import '../indicators/slidex_indicator.dart';
import 'slidex_360_viewer.dart';
import 'slidex_card_swiper.dart';
import 'slidex_gallery_view.dart';
import 'slidex_image_slider.dart';
import 'slidex_story_view.dart';
import 'slidex_vertical.dart';

/// Premier Motion Engine & Carousel Widget for Flutter.
class SlideX extends StatefulWidget {
  final IndexedWidgetBuilder? itemBuilder;
  final List<Widget>? items;
  final int itemCount;
  final SlideXConfig config;
  final SlideXEffect effect;
  final SlideXController? controller;
  final ValueChanged<int>? onPageChanged;
  final SlideXIndicatorType indicatorType;
  final Color indicatorActiveColor;
  final Color indicatorInactiveColor;
  final Alignment indicatorAlignment;

  /// Default minimal & list item constructor.
  const SlideX({
    super.key,
    required List<Widget> items,
    SlideXConfig? config,
    SlideXEffect? effect,
    this.controller,
    this.onPageChanged,
    this.indicatorType = SlideXIndicatorType.dot,
    this.indicatorActiveColor = const Color(0xFF2196F3),
    this.indicatorInactiveColor = const Color(0xFFE0E0E0),
    this.indicatorAlignment = Alignment.bottomCenter,
  }) : items = items,
       itemCount = items.length,
       itemBuilder = null,
       config = config ?? const SlideXConfig(),
       effect = effect ?? const SlideEffect();

  /// Builder constructor for lazy dynamic widget rendering.
  const SlideX.builder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    SlideXConfig? config,
    SlideXEffect? effect,
    this.controller,
    this.onPageChanged,
    this.indicatorType = SlideXIndicatorType.dot,
    this.indicatorActiveColor = const Color(0xFF2196F3),
    this.indicatorInactiveColor = const Color(0xFFE0E0E0),
    this.indicatorAlignment = Alignment.bottomCenter,
  }) : items = null,
       config = config ?? const SlideXConfig(),
       effect = effect ?? const SlideEffect();

  /// Infinite Carousel constructor with auto-play & scale effect.
  SlideX.carousel({
    super.key,
    required List<Widget> items,
    bool autoPlay = true,
    Duration autoPlayInterval = const Duration(seconds: 3),
    double viewportFraction = 0.85,
    SlideXEffect? effect,
    this.controller,
    this.onPageChanged,
    this.indicatorType = SlideXIndicatorType.expandingDot,
    this.indicatorActiveColor = const Color(0xFF2196F3),
    this.indicatorInactiveColor = const Color(0xFFE0E0E0),
    this.indicatorAlignment = Alignment.bottomCenter,
  }) : items = items,
       itemCount = items.length,
       itemBuilder = null,
       config = SlideXConfig(
         autoPlay: autoPlay,
         autoPlayInterval: autoPlayInterval,
         viewportFraction: viewportFraction,
         loopMode: SlideXLoopMode.infinite,
       ),
       effect = effect ?? const ZoomEffect();

  /// Banner Slider constructor with auto-play & progress line.
  SlideX.banner({
    super.key,
    required List<Widget> items,
    bool autoPlay = true,
    Duration autoPlayInterval = const Duration(seconds: 4),
    this.controller,
    this.onPageChanged,
    this.indicatorType = SlideXIndicatorType.progressLine,
    this.indicatorActiveColor = const Color(0xFF2196F3),
    this.indicatorInactiveColor = const Color(0xFFE0E0E0),
    this.indicatorAlignment = Alignment.bottomCenter,
  }) : items = items,
       itemCount = items.length,
       itemBuilder = null,
       config = SlideXConfig(
         autoPlay: autoPlay,
         autoPlayInterval: autoPlayInterval,
         viewportFraction: 1.0,
       ),
       effect = const ParallaxEffect();

  /// Swiper constructor with 3D Coverflow or Stack Effect.
  const SlideX.swiper({
    super.key,
    required List<Widget> items,
    SlideXEffect? effect,
    this.controller,
    this.onPageChanged,
    this.indicatorType = SlideXIndicatorType.dot,
    this.indicatorActiveColor = const Color(0xFF2196F3),
    this.indicatorInactiveColor = const Color(0xFFE0E0E0),
    this.indicatorAlignment = Alignment.bottomCenter,
  }) : items = items,
       itemCount = items.length,
       itemBuilder = null,
       config = const SlideXConfig(viewportFraction: 0.8),
       effect = effect ?? const CoverflowEffect();

  /// Onboarding Pager constructor with Elastic/Bounce Effect.
  const SlideX.onboarding({
    super.key,
    required List<Widget> items,
    this.controller,
    this.onPageChanged,
    this.indicatorType = SlideXIndicatorType.expandingDot,
    this.indicatorActiveColor = const Color(0xFF2196F3),
    this.indicatorInactiveColor = const Color(0xFFE0E0E0),
    this.indicatorAlignment = Alignment.bottomCenter,
  }) : items = items,
       itemCount = items.length,
       itemBuilder = null,
       config = const SlideXConfig(autoPlay: false, viewportFraction: 1.0),
       effect = const ElasticEffect();

  /// Story Viewer static helper constructor.
  static Widget story({
    required List<SlideXStoryItem> items,
    VoidCallback? onCompleted,
    ValueChanged<int>? onItemChanged,
  }) {
    return SlideXStoryView(
      items: items,
      onCompleted: onCompleted,
      onItemChanged: onItemChanged,
    );
  }

  /// Gallery Viewer static helper constructor.
  static Widget gallery({
    required List<Widget> items,
    List<Widget>? thumbnails,
    double thumbnailHeight = 72.0,
    SlideXEffect effect = const ScaleEffect(),
    SlideXThumbnailPosition thumbnailPosition = SlideXThumbnailPosition.bottom,
    bool enableFullscreenZoom = true,
    bool showBadge = true,
    Color activeBorderColor = const Color(0xFF6366F1),
    Color inactiveBorderColor = Colors.transparent,
    double activeBorderWidth = 2.5,
    Color badgeBackgroundColor = const Color(0x99000000),
    TextStyle? badgeTextStyle,
    IconData fullscreenIcon = Icons.fullscreen,
    Color fullscreenIconColor = Colors.white,
    Color fullscreenIconBackgroundColor = const Color(0x99000000),
    double thumbnailSpacing = 8.0,
    BorderRadius thumbnailBorderRadius = const BorderRadius.all(Radius.circular(12)),
    BorderRadius galleryBorderRadius = const BorderRadius.all(Radius.circular(20)),
    ValueChanged<int>? onIndexChanged,
  }) {
    return SlideXGalleryView(
      items: items,
      thumbnails: thumbnails,
      thumbnailHeight: thumbnailHeight,
      effect: effect,
      thumbnailPosition: thumbnailPosition,
      enableFullscreenZoom: enableFullscreenZoom,
      showBadge: showBadge,
      activeBorderColor: activeBorderColor,
      inactiveBorderColor: inactiveBorderColor,
      activeBorderWidth: activeBorderWidth,
      badgeBackgroundColor: badgeBackgroundColor,
      badgeTextStyle: badgeTextStyle,
      fullscreenIcon: fullscreenIcon,
      fullscreenIconColor: fullscreenIconColor,
      fullscreenIconBackgroundColor: fullscreenIconBackgroundColor,
      thumbnailSpacing: thumbnailSpacing,
      thumbnailBorderRadius: thumbnailBorderRadius,
      galleryBorderRadius: galleryBorderRadius,
      onIndexChanged: onIndexChanged,
    );
  }

  /// Tinder-style Card Swiper static helper constructor.
  static Widget cardSwipe({
    required List<Widget> cards,
    SlideXCardSwiperController? controller,
    ValueChanged<int>? onSwipeLeft,
    ValueChanged<int>? onSwipeRight,
    void Function(int index, SlideXSwipeDirection direction)? onSwiped,
    VoidCallback? onEnd,
    double threshold = 120.0,
    bool loop = true,
    bool enableLikeNopeBadges = true,
  }) {
    return SlideXCardSwiper(
      cards: cards,
      controller: controller,
      onSwipeLeft: onSwipeLeft,
      onSwipeRight: onSwipeRight,
      onSwiped: onSwiped,
      onEnd: onEnd,
      threshold: threshold,
      loop: loop,
      enableLikeNopeBadges: enableLikeNopeBadges,
    );
  }

  /// Enterprise Image Slider static helper constructor.
  static Widget imageSlider({
    required List<SlideXImageData> images,
    double height = 240.0,
    double viewportFraction = 0.9,
    bool autoPlay = true,
    Duration autoPlayInterval = const Duration(seconds: 4),
    SlideXEffect effect = const ParallaxEffect(),
    SlideXIndicatorType indicatorType = SlideXIndicatorType.expandingDot,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(20)),
    ValueChanged<int>? onPageChanged,
  }) {
    return SlideXImageSlider(
      images: images,
      height: height,
      viewportFraction: viewportFraction,
      autoPlay: autoPlay,
      autoPlayInterval: autoPlayInterval,
      effect: effect,
      indicatorType: indicatorType,
      borderRadius: borderRadius,
      onPageChanged: onPageChanged,
    );
  }

  /// 360-Degree Interactive Product Spinner helper constructor.
  static Widget product360({
    required List<ImageProvider> imageList,
    double height = 300.0,
    bool autoRotate = false,
    Duration autoRotateInterval = const Duration(milliseconds: 80),
    ValueChanged<int>? onFrameChanged,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(20)),
  }) {
    return SlideX360Viewer(
      imageList: imageList,
      height: height,
      autoRotate: autoRotate,
      autoRotateInterval: autoRotateInterval,
      onFrameChanged: onFrameChanged,
      borderRadius: borderRadius,
    );
  }

  /// Dedicated Vertical Axis Slider helper constructor.
  static Widget vertical({
    required List<Widget> items,
    double height = 400.0,
    SlideXEffect effect = const SlideEffect(),
    SlideXIndicatorType indicatorType = SlideXIndicatorType.expandingDot,
    bool showControls = true,
    SlideXController? controller,
    ValueChanged<int>? onPageChanged,
  }) {
    return SlideXVertical(
      items: items,
      height: height,
      effect: effect,
      indicatorType: indicatorType,
      showControls: showControls,
      controller: controller,
      onPageChanged: onPageChanged,
    );
  }

  @override
  State<SlideX> createState() => _SlideXState();
}

class _SlideXState extends State<SlideX> {
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
    if (widget.itemCount == 0) return const SizedBox.shrink();

    final builder =
        widget.itemBuilder ?? (context, index) => widget.items![index];

    final isVerticalAxis = widget.config.scrollDirection == SlideXAxis.vertical ||
        widget.indicatorAlignment == Alignment.centerRight ||
        widget.indicatorAlignment == Alignment.centerLeft;

    final indicatorWidget = AnimatedBuilder(
      animation: _activeController,
      builder: (context, _) {
        return SlideXIndicator(
          count: widget.itemCount,
          pageOffset: _activeController.pageOffset,
          type: widget.indicatorType,
          activeColor: widget.indicatorActiveColor,
          inactiveColor: widget.indicatorInactiveColor,
          isVertical: isVerticalAxis,
          onTap: (index) => _activeController.animateToPage(index),
        );
      },
    );

    return SlideXView(
      itemBuilder: builder,
      itemCount: widget.itemCount,
      config: widget.config,
      effect: widget.effect,
      controller: _activeController,
      onPageChanged: widget.onPageChanged,
      indicator: indicatorWidget,
      indicatorAlignment: widget.indicatorAlignment,
    );
  }
}
