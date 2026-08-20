import 'package:flutter/material.dart';
import '../core/slidex_enums.dart';

/// Interactive indicator widget for SlideX.
class SlideXIndicator extends StatelessWidget {
  final int count;
  final double pageOffset;
  final SlideXIndicatorType type;
  final Color activeColor;
  final Color inactiveColor;
  final double dotWidth;
  final double dotHeight;
  final double spacing;
  final bool isVertical;
  final ValueChanged<int>? onTap;

  const SlideXIndicator({
    super.key,
    required this.count,
    required this.pageOffset,
    this.type = SlideXIndicatorType.dot,
    this.activeColor = const Color(0xFF2196F3),
    this.inactiveColor = const Color(0xFFE0E0E0),
    this.dotWidth = 8.0,
    this.dotHeight = 8.0,
    this.spacing = 8.0,
    this.isVertical = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (count <= 1 || type == SlideXIndicatorType.none) {
      return const SizedBox.shrink();
    }

    switch (type) {
      case SlideXIndicatorType.number:
        return _buildNumberIndicator();
      case SlideXIndicatorType.progressLine:
        return _buildProgressLineIndicator();
      case SlideXIndicatorType.expandingDot:
        return _buildExpandingDotIndicator();
      case SlideXIndicatorType.worm:
      case SlideXIndicatorType.scale:
      case SlideXIndicatorType.slide:
      case SlideXIndicatorType.dot:
      default:
        return _buildDotIndicator();
    }
  }

  Widget _buildDotIndicator() {
    final activeIndex = pageOffset.round() % count;

    final children = List.generate(count, (index) {
      final isActive = index == activeIndex;
      return GestureDetector(
        onTap: () => onTap?.call(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(
            horizontal: isVertical ? 0 : spacing / 2,
            vertical: isVertical ? spacing / 2 : 0,
          ),
          width: dotWidth,
          height: dotHeight,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(dotHeight / 2),
          ),
        ),
      );
    });

    if (isVertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _buildExpandingDotIndicator() {
    final activeIndex = pageOffset.round() % count;

    final children = List.generate(count, (index) {
      final isActive = index == activeIndex;
      return GestureDetector(
        onTap: () => onTap?.call(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(
            horizontal: isVertical ? 0 : spacing / 2,
            vertical: isVertical ? spacing / 2 : 0,
          ),
          width: isVertical ? dotWidth : (isActive ? dotWidth * 2.5 : dotWidth),
          height: isVertical ? (isActive ? dotHeight * 2.5 : dotHeight) : dotHeight,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(dotHeight / 2),
          ),
        ),
      );
    });

    if (isVertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _buildNumberIndicator() {
    final current = (pageOffset.round() % count) + 1;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '$current / $count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildProgressLineIndicator() {
    final progress = count > 0 ? ((pageOffset + 1) / count).clamp(0.0, 1.0) : 0.0;

    if (isVertical) {
      return Container(
        width: 4,
        height: count * (dotHeight + spacing),
        decoration: BoxDecoration(
          color: inactiveColor,
          borderRadius: BorderRadius.circular(2),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: progress,
          child: Container(
            decoration: BoxDecoration(
              color: activeColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      );
    }

    return Container(
      height: 4,
      width: count * (dotWidth + spacing),
      decoration: BoxDecoration(
        color: inactiveColor,
        borderRadius: BorderRadius.circular(2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: activeColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}
