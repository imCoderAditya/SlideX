import 'package:flutter/widgets.dart';
import '../core/slidex_config.dart';

/// Base contract for all 2D and 3D SlideX motion effects.
abstract class SlideXEffect {
  const SlideXEffect();

  /// Build transformed slide item widget based on relative position (-1.0 to 1.0).
  ///
  /// [position] is 0.0 when item is centered, -1.0 when scrolled off to left/top,
  /// and +1.0 when scrolled off to right/bottom.
  Widget buildTransform({
    required BuildContext context,
    required Widget child,
    required double position,
    required SlideXConfig config,
  });
}
