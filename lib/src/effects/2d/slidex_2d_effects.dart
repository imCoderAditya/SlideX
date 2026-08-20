import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/widgets.dart';
import '../../core/slidex_config.dart';
import '../../core/slidex_enums.dart';
import '../slidex_effect.dart';

/// 1. Standard Slide Motion Effect
class SlideEffect extends SlideXEffect {
  const SlideEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    return child;
  }
}

/// 2. Smooth Fade Opacity Effect
class FadeEffect extends SlideXEffect {
  final double minOpacity;
  const FadeEffect({this.minOpacity = 0.2});

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final opacity = (1.0 - position.abs()).clamp(minOpacity, 1.0);
    return Opacity(opacity: opacity, child: child);
  }
}

/// 3. Zoom In / Out Depth Effect
class ZoomEffect extends SlideXEffect {
  final double zoomScale;
  const ZoomEffect({this.zoomScale = 0.85});

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final scale = position == 0
        ? 1.0
        : (1.0 - (position.abs() * (1 - zoomScale))).clamp(zoomScale, 1.0);
    return Transform.scale(
      scale: scale,
      child: child,
    );
  }
}

/// 4. Dynamic Scale Effect
class ScaleEffect extends SlideXEffect {
  final double scaleFactor;
  const ScaleEffect({this.scaleFactor = 0.8});

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final scale = math.max(scaleFactor, 1.0 - position.abs() * (1.0 - scaleFactor));
    return Transform.scale(scale: scale, child: child);
  }
}

/// 5. Gaussian Blur Motion Effect
class BlurEffect extends SlideXEffect {
  final double maxSigma;
  const BlurEffect({this.maxSigma = 8.0});

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final sigma = (position.abs() * maxSigma).clamp(0.0, maxSigma);
    if (sigma <= 0.1) return child;
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: child,
    );
  }
}

/// 6. Color Overlay Blend Effect
class OverlayEffect extends SlideXEffect {
  final Color overlayColor;
  const OverlayEffect({this.overlayColor = const Color(0x99000000)});

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final opacity = position.abs().clamp(0.0, 1.0);
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        if (opacity > 0.01)
          Container(
            color: overlayColor.withValues(alpha: overlayColor.a * opacity),
          ),
      ],
    );
  }
}

/// 7. 2D Card Flip Effect
class FlipEffect extends SlideXEffect {
  const FlipEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final angle = position * math.pi;
    final isHorizontal = config.scrollDirection == SlideXAxis.horizontal;
    final matrix = Matrix4.identity()..setEntry(3, 2, config.perspective);

    if (isHorizontal) {
      matrix.rotateY(angle);
    } else {
      matrix.rotateX(angle);
    }

    return Transform(
      transform: matrix,
      alignment: Alignment.center,
      child: child,
    );
  }
}

/// 8. Stretch & Elastic Compression Effect
class StretchEffect extends SlideXEffect {
  const StretchEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final scaleX = 1.0 + (position.abs() * 0.3);
    final scaleY = (1.0 - (position.abs() * 0.2)).clamp(0.5, 1.0);
    return Transform.scale(
      scaleX: config.scrollDirection == SlideXAxis.horizontal ? scaleX : scaleY,
      scaleY: config.scrollDirection == SlideXAxis.horizontal ? scaleY : scaleX,
      child: child,
    );
  }
}

/// 9. Reveal Unfold Mask Effect
class RevealEffect extends SlideXEffect {
  const RevealEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final opacity = (1.0 - (position.abs() * 0.8)).clamp(0.0, 1.0);
    final scale = (1.0 - (position.abs() * 0.15)).clamp(0.85, 1.0);
    return Opacity(
      opacity: opacity,
      child: Transform.scale(scale: scale, child: child),
    );
  }
}

/// 10. Liquid Wave Distortion Effect
class LiquidEffect extends SlideXEffect {
  const LiquidEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final skew = math.sin(position * math.pi) * 0.2;
    final matrix = Matrix4.skewX(skew);
    return Transform(
      transform: matrix,
      alignment: Alignment.center,
      child: child,
    );
  }
}

/// 11. Parallax Depth Layering Effect
class ParallaxEffect extends SlideXEffect {
  final double parallaxFactor;
  const ParallaxEffect({this.parallaxFactor = 0.5});

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final isHorizontal = config.scrollDirection == SlideXAxis.horizontal;
    final offset = position * 150 * parallaxFactor;
    return Transform.translate(
      offset: isHorizontal ? Offset(offset, 0) : Offset(0, offset),
      child: child,
    );
  }
}

/// 12. Elastic Spring Overshoot Effect
class ElasticEffect extends SlideXEffect {
  const ElasticEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final factor = math.sin(position.abs() * math.pi * 2) * 0.15;
    final scale = 1.0 + factor;
    return Transform.scale(scale: scale, child: child);
  }
}

/// 13. Bounce Impact Motion Effect
class BounceEffect extends SlideXEffect {
  const BounceEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final bounce = math.sin(position.abs() * math.pi) * 0.2;
    return Transform.translate(
      offset: Offset(0, -bounce * 100),
      child: child,
    );
  }
}

/// 14. Stage Curtain Unroll Effect
class CurtainEffect extends SlideXEffect {
  const CurtainEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final scaleX = position < 0 ? (1.0 + position).clamp(0.0, 1.0) : 1.0;
    return Transform.scale(
      scaleX: scaleX,
      alignment: position < 0 ? Alignment.centerRight : Alignment.centerLeft,
      child: child,
    );
  }
}

/// 15. Dynamic Morph Blend Effect
class MorphEffect extends SlideXEffect {
  const MorphEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final absPos = position.abs();
    final scale = (1.0 - absPos * 0.2).clamp(0.8, 1.0);
    final rotation = position * 0.1;
    final opacity = (1.0 - absPos * 0.4).clamp(0.2, 1.0);

    return Opacity(
      opacity: opacity,
      child: Transform.rotate(
        angle: rotation,
        child: Transform.scale(scale: scale, child: child),
      ),
    );
  }
}
