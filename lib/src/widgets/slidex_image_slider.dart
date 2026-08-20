import 'package:flutter/material.dart';

import '../core/slidex_config.dart';
import '../core/slidex_controller.dart';
import '../core/slidex_enums.dart';
import '../effects/2d/slidex_2d_effects.dart';
import '../effects/slidex_effect.dart';
import 'slidex_main.dart';

/// Single Image Data Model for [SlideXImageSlider].
class SlideXImageData {
  final ImageProvider image;
  final String? title;
  final String? subtitle;
  final String? badge;

  const SlideXImageData({
    required this.image,
    this.title,
    this.subtitle,
    this.badge,
  });

  factory SlideXImageData.network(
    String url, {
    String? title,
    String? subtitle,
    String? badge,
  }) {
    return SlideXImageData(
      image: NetworkImage(url),
      title: title,
      subtitle: subtitle,
      badge: badge,
    );
  }

  factory SlideXImageData.asset(
    String assetName, {
    String? title,
    String? subtitle,
    String? badge,
  }) {
    return SlideXImageData(
      image: AssetImage(assetName),
      title: title,
      subtitle: subtitle,
      badge: badge,
    );
  }
}

/// Feature-rich Enterprise Image Slider for SlideX.
class SlideXImageSlider extends StatefulWidget {
  final List<SlideXImageData> images;
  final double height;
  final double viewportFraction;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final SlideXEffect effect;
  final SlideXIndicatorType indicatorType;
  final BorderRadius borderRadius;
  final ValueChanged<int>? onPageChanged;
  final bool enableLightbox;

  const SlideXImageSlider({
    super.key,
    required this.images,
    this.height = 240.0,
    this.viewportFraction = 0.9,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.effect = const ParallaxEffect(),
    this.indicatorType = SlideXIndicatorType.expandingDot,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.onPageChanged,
    this.enableLightbox = true,
  });

  @override
  State<SlideXImageSlider> createState() => _SlideXImageSliderState();
}

class _SlideXImageSliderState extends State<SlideXImageSlider> {
  late SlideXController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SlideXController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: widget.height,
      child: SlideX(
        controller: _controller,
        config: SlideXConfig(
          autoPlay: widget.autoPlay,
          autoPlayInterval: widget.autoPlayInterval,
          viewportFraction: widget.viewportFraction,
          loopMode: SlideXLoopMode.infinite,
        ),
        effect: widget.effect,
        indicatorType: widget.indicatorType,
        onPageChanged: widget.onPageChanged,
        items: List.generate(widget.images.length, (index) {
          final item = widget.images[index];

          Widget card = Container(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  // Image
                  Image(
                    image: item.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFF1E293B),
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.white54,
                          size: 48,
                        ),
                      ),
                    ),
                  ),

                  // Bottom Gradient Backdrop
                  if (item.title != null || item.subtitle != null)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.8),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.5, 1.0],
                          ),
                        ),
                      ),
                    ),

                  // Badge Tag Overlay
                  if (item.badge != null)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item.badge!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  // Title & Subtitle Overlay
                  if (item.title != null || item.subtitle != null)
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (item.title != null)
                            Text(
                              item.title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (item.subtitle != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              item.subtitle!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );

          return card;
        }),
      ),
    );
  }
}
