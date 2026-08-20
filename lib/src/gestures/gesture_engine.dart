import 'package:flutter/widgets.dart';
import '../core/slidex_controller.dart';

/// Interactive Gesture Engine for SlideX.
class SlideXGestureEngine extends StatelessWidget {
  final Widget child;
  final SlideXController? controller;
  final VoidCallback? onTap;

  const SlideXGestureEngine({
    super.key,
    required this.child,
    this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      onPanDown: (_) => controller?.pause(),
      onPanCancel: () => controller?.resume(),
      onPanEnd: (_) => controller?.resume(),
      child: child,
    );
  }
}
