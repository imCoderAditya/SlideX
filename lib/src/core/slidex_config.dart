import 'package:flutter/widgets.dart';
import 'slidex_enums.dart';

/// Configuration options for [SlideX] motion engine.
class SlideXConfig {
  /// Scroll direction axis (horizontal or vertical).
  final SlideXAxis scrollDirection;

  /// Viewport fraction occupied by each slide item (0.0 to 1.0).
  final double viewportFraction;

  /// Whether auto-play is enabled.
  final bool autoPlay;

  /// Duration interval between auto-play page transitions.
  final Duration autoPlayInterval;

  /// Duration of transition animation when auto-playing or changing pages.
  final Duration animationDuration;

  /// Transition animation curve.
  final Curve animationCurve;

  /// Whether infinite looping is active.
  final SlideXLoopMode loopMode;

  /// Enable drag/swipe gesture interaction.
  final bool enableGestures;

  /// Enable dynamic height calculation based on current slide content.
  final bool dynamicHeight;

  /// Enable keyboard arrow navigation.
  final bool enableKeyboard;

  /// Clip behavior applied to viewport container.
  final Clip clipBehavior;

  /// Depth/perspective factor for 3D transforms (0.001 to 0.005 recommended).
  final double perspective;

  /// Enable predictive precaching of adjacent network/asset images.
  final bool enablePreloading;

  /// Whether auto-play should pause when pointer hovers over carousel.
  final bool pauseOnHover;

  /// Reverse auto-play direction (slides right-to-left instead of left-to-right).
  final bool autoPlayReverse;

  /// Create a SlideX configuration instance.
  const SlideXConfig({
    this.scrollDirection = SlideXAxis.horizontal,
    this.viewportFraction = 1.0,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.animationDuration = const Duration(milliseconds: 350),
    this.animationCurve = Curves.fastOutSlowIn,
    this.loopMode = SlideXLoopMode.infinite,
    this.enableGestures = true,
    this.dynamicHeight = false,
    this.enableKeyboard = true,
    this.clipBehavior = Clip.none,
    this.perspective = 0.002,
    this.enablePreloading = true,
    this.pauseOnHover = true,
    this.autoPlayReverse = false,
  });

  /// Copy current config with updated fields.
  SlideXConfig copyWith({
    SlideXAxis? scrollDirection,
    double? viewportFraction,
    bool? autoPlay,
    Duration? autoPlayInterval,
    Duration? animationDuration,
    Curve? animationCurve,
    SlideXLoopMode? loopMode,
    bool? enableGestures,
    bool? dynamicHeight,
    bool? enableKeyboard,
    Clip? clipBehavior,
    double? perspective,
    bool? enablePreloading,
    bool? pauseOnHover,
    bool? autoPlayReverse,
  }) {
    return SlideXConfig(
      scrollDirection: scrollDirection ?? this.scrollDirection,
      viewportFraction: viewportFraction ?? this.viewportFraction,
      autoPlay: autoPlay ?? this.autoPlay,
      autoPlayInterval: autoPlayInterval ?? this.autoPlayInterval,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      loopMode: loopMode ?? this.loopMode,
      enableGestures: enableGestures ?? this.enableGestures,
      dynamicHeight: dynamicHeight ?? this.dynamicHeight,
      enableKeyboard: enableKeyboard ?? this.enableKeyboard,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      perspective: perspective ?? this.perspective,
      enablePreloading: enablePreloading ?? this.enablePreloading,
      pauseOnHover: pauseOnHover ?? this.pauseOnHover,
      autoPlayReverse: autoPlayReverse ?? this.autoPlayReverse,
    );
  }
}
