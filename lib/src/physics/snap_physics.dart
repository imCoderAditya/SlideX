import 'package:flutter/widgets.dart';

/// Clean 1-page snap physics engine for SlideX.
class SlideXSnapPhysics extends PageScrollPhysics {
  /// Create custom snap physics instance.
  const SlideXSnapPhysics({super.parent});

  @override
  SlideXSnapPhysics applyTo(ScrollPhysics? ancestor) {
    return SlideXSnapPhysics(parent: buildParent(ancestor));
  }
}
