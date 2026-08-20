import 'package:flutter/material.dart';

/// 360-Degree Interactive Product Rotation Viewer Widget for SlideX.
class SlideX360Viewer extends StatefulWidget {
  final List<ImageProvider> imageList;
  final double height;
  final bool autoRotate;
  final Duration autoRotateInterval;
  final ValueChanged<int>? onFrameChanged;
  final BorderRadius borderRadius;

  const SlideX360Viewer({
    super.key,
    required this.imageList,
    this.height = 300.0,
    this.autoRotate = false,
    this.autoRotateInterval = const Duration(milliseconds: 80),
    this.onFrameChanged,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  });

  @override
  State<SlideX360Viewer> createState() => _SlideX360ViewerState();
}

class _SlideX360ViewerState extends State<SlideX360Viewer> {
  int _currentFrame = 0;
  double _dragAccumulator = 0.0;
  final double _sensitivity = 12.0;

  void _onPanUpdate(DragUpdateDetails details) {
    _dragAccumulator += details.delta.dx;
    if (_dragAccumulator.abs() > _sensitivity) {
      final step = (_dragAccumulator / _sensitivity).toInt();
      _dragAccumulator -= step * _sensitivity;

      setState(() {
        _currentFrame = (_currentFrame - step) % widget.imageList.length;
        if (_currentFrame < 0) {
          _currentFrame += widget.imageList.length;
        }
      });

      widget.onFrameChanged?.call(_currentFrame);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageList.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: widget.height,
      child: GestureDetector(
        onPanUpdate: _onPanUpdate,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            color: Colors.white.withValues(alpha: 0.04),
          ),
          child: ClipRRect(
            borderRadius: widget.borderRadius,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Render Active Frame
                Image(
                  image:
                      widget.imageList[_currentFrame % widget.imageList.length],
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),

                // Floating 360 Indicator Badge
                Positioned(
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.threed_rotation,
                          color: Color(0xFFEC4899),
                          size: 18,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Drag to Rotate 360°',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
