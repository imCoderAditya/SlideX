import 'package:flutter/widgets.dart';
import '../core/slidex_config.dart';
import '../effects/slidex_effect.dart';

/// Engine responsible for calculating relative scroll positions and applying 2D/3D transformations.
class SlideXEngine {
  /// Calculate relative position (-1.0 to 1.0) of a page index given current scroll page value.
  static double calculatePosition({
    required int index,
    required double pageOffset,
    required int itemCount,
    required bool isLooping,
  }) {
    double position = index - pageOffset;

    if (isLooping && itemCount > 1) {
      // Wrap-around calculations for infinite looping carousels
      if (position < -itemCount / 2) {
        position += itemCount;
      } else if (position > itemCount / 2) {
        position -= itemCount;
      }
    }

    return position;
  }

  /// Apply transform effect to slide item.
  static Widget applyEffect({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXEffect effect,
    required SlideXConfig config,
  }) {
    return RepaintBoundary(
      child: effect.buildTransform(
        context: context,
        child: child,
        position: position,
        config: config,
      ),
    );
  }
}
