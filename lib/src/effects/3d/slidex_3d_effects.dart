import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../core/slidex_config.dart';
import '../../core/slidex_enums.dart';
import '../slidex_effect.dart';

/// 1. Classic Apple Coverflow 3D Perspective Effect
class CoverflowEffect extends SlideXEffect {
  final double depth;
  final double rotateAngle;

  const CoverflowEffect({this.depth = 120.0, this.rotateAngle = 0.45});

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final absPos = position.abs();
    final isHorizontal = config.scrollDirection == SlideXAxis.horizontal;

    final matrix = Matrix4.identity()..setEntry(3, 2, config.perspective);

    // Apply rotation based on position
    final rotation = -position * rotateAngle;
    if (isHorizontal) {
      matrix.rotateY(rotation);
      matrix.leftTranslateByDouble(0.0, 0.0, -absPos * depth, 1.0);
    } else {
      matrix.rotateX(rotation);
      matrix.leftTranslateByDouble(0.0, 0.0, -absPos * depth, 1.0);
    }

    return Transform(
      transform: matrix,
      alignment: Alignment.center,
      child: child,
    );
  }
}

/// 2. 3D Rotating Cube Box Effect
class CubeEffect extends SlideXEffect {
  const CubeEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final isHorizontal = config.scrollDirection == SlideXAxis.horizontal;
    final angle = position * (math.pi / 2);
    final matrix = Matrix4.identity()..setEntry(3, 2, config.perspective);

    if (isHorizontal) {
      matrix.rotateY(angle);
    } else {
      matrix.rotateX(angle);
    }

    final alignment = position > 0
        ? (isHorizontal ? Alignment.centerLeft : Alignment.topCenter)
        : (isHorizontal ? Alignment.centerRight : Alignment.bottomCenter);

    return Transform(transform: matrix, alignment: alignment, child: child);
  }
}

/// 3. Rotary Wheel Drum Effect
class WheelEffect extends SlideXEffect {
  const WheelEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final isHorizontal = config.scrollDirection == SlideXAxis.horizontal;
    final angle = position * (math.pi / 4);
    final matrix = Matrix4.identity()..setEntry(3, 2, config.perspective);

    if (isHorizontal) {
      matrix.rotateZ(angle);
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

/// 4. 3D Rolling Cylinder Roller Effect
class CylinderEffect extends SlideXEffect {
  final double radius;
  const CylinderEffect({this.radius = 100.0});

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final angle = position * 0.5;
    final matrix = Matrix4.identity()..setEntry(3, 2, config.perspective);
    matrix.rotateY(angle);
    matrix.leftTranslateByDouble(0.0, 0.0, (1 - position.abs()) * radius, 1.0);

    return Transform(
      transform: matrix,
      alignment: Alignment.center,
      child: child,
    );
  }
}

/// 5. 3D Curved Sphere Carousel Effect
class SphereEffect extends SlideXEffect {
  const SphereEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final angleX = position * 0.4;
    final angleY = position * 0.4;
    final matrix = Matrix4.identity()
      ..setEntry(3, 2, config.perspective)
      ..rotateX(angleX)
      ..rotateY(angleY);

    return Transform(
      transform: matrix,
      alignment: Alignment.center,
      child: child,
    );
  }
}

/// 6. 3D Ring Orbital Carousel
class RingEffect extends SlideXEffect {
  const RingEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final absPos = position.abs();
    final matrix = Matrix4.identity()..setEntry(3, 2, config.perspective);
    matrix.leftTranslateByDouble(0.0, absPos * 30, -absPos * 150, 1.0);
    matrix.rotateY(position * 0.5);

    return Transform(
      transform: matrix,
      alignment: Alignment.center,
      child: child,
    );
  }
}

/// 7. 3D Planet Orbit Motion
class OrbitEffect extends SlideXEffect {
  const OrbitEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final angle = position * math.pi / 3;
    final matrix = Matrix4.identity()..setEntry(3, 2, config.perspective);
    matrix.rotateZ(angle * 0.3);
    matrix.rotateY(angle);

    return Transform(
      transform: matrix,
      alignment: Alignment.center,
      child: child,
    );
  }
}

/// 8. DNA Helix Spiral Motion
class HelixEffect extends SlideXEffect {
  const HelixEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final angle = position * math.pi;
    final translateY = position * 50;
    final matrix = Matrix4.identity()..setEntry(3, 2, config.perspective);
    matrix.leftTranslateByDouble(0.0, translateY, 0.0, 1.0);
    matrix.rotateY(angle);

    return Transform(
      transform: matrix,
      alignment: Alignment.center,
      child: child,
    );
  }
}

/// 9. 3D Stack Cards Deck
class Stack3DEffect extends SlideXEffect {
  const Stack3DEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    if (position < 0) {
      // Current active or past slide slides out
      final opacity = (1.0 + position).clamp(0.0, 1.0);
      return Opacity(
        opacity: opacity,
        child: Transform.translate(
          offset: Offset(position * 300, 0),
          child: child,
        ),
      );
    } else {
      // Future slides stack underneath
      final scale = (1.0 - (position * 0.08)).clamp(0.7, 1.0);
      final translateY = position * 15;
      return Transform.translate(
        offset: Offset(0, translateY),
        child: Transform.scale(scale: scale, child: child),
      );
    }
  }
}

/// 10. Deep 3D Perspective Tilt
class PerspectiveEffect extends SlideXEffect {
  const PerspectiveEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final matrix = Matrix4.identity()..setEntry(3, 2, config.perspective);
    matrix.rotateX(position.abs() * 0.3);
    matrix.rotateY(position * 0.2);

    return Transform(
      transform: matrix,
      alignment: Alignment.center,
      child: child,
    );
  }
}

/// 11. 3D Warp Speed Tunnel
class TunnelEffect extends SlideXEffect {
  const TunnelEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final absPos = position.abs();
    final scale = (1.0 - absPos * 0.5).clamp(0.1, 1.0);
    final opacity = (1.0 - absPos * 0.7).clamp(0.0, 1.0);
    final matrix = Matrix4.identity()..setEntry(3, 2, config.perspective);
    matrix.leftTranslateByDouble(0.0, 0.0, -absPos * 300, 1.0);

    return Opacity(
      opacity: opacity,
      child: Transform(
        transform: matrix,
        alignment: Alignment.center,
        child: Transform.scale(scale: scale, child: child),
      ),
    );
  }
}

/// 12. 3D Infinity Loop Figure Eight
class InfinityLoopEffect extends SlideXEffect {
  const InfinityLoopEffect();

  @override
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  }) {
    final t = position * math.pi;
    final dx = math.sin(t) * 80;
    final dy = math.sin(2 * t) * 40;
    final scale = (1.0 - position.abs() * 0.2).clamp(0.7, 1.0);

    return Transform.translate(
      offset: Offset(dx, dy),
      child: Transform.scale(scale: scale, child: child),
    );
  }
}
