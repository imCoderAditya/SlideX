import 'package:flutter/material.dart';

/// Single item model for SlideX Story Viewer.
class SlideXStoryItem {
  final Widget content;
  final Duration duration;

  const SlideXStoryItem({
    required this.content,
    this.duration = const Duration(seconds: 5),
  });

  /// Factory helper for image stories.
  factory SlideXStoryItem.image({
    required ImageProvider image,
    Duration duration = const Duration(seconds: 5),
    BoxFit fit = BoxFit.cover,
  }) {
    return SlideXStoryItem(
      duration: duration,
      content: Image(image: image, fit: fit, width: double.infinity, height: double.infinity),
    );
  }
}

/// Interactive Story Viewer widget for SlideX.
class SlideXStoryView extends StatefulWidget {
  final List<SlideXStoryItem> items;
  final VoidCallback? onCompleted;
  final ValueChanged<int>? onItemChanged;

  const SlideXStoryView({
    super.key,
    required this.items,
    this.onCompleted,
    this.onItemChanged,
  });

  @override
  State<SlideXStoryView> createState() => _SlideXStoryViewState();
}

class _SlideXStoryViewState extends State<SlideXStoryView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this);
    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextItem();
      }
    });
    _playStory(_currentIndex);
  }

  void _playStory(int index) {
    if (index >= widget.items.length) {
      widget.onCompleted?.call();
      return;
    }
    setState(() {
      _currentIndex = index;
    });
    widget.onItemChanged?.call(_currentIndex);
    _animController.duration = widget.items[_currentIndex].duration;
    _animController.forward(from: 0.0);
  }

  void _nextItem() {
    if (_currentIndex < widget.items.length - 1) {
      _playStory(_currentIndex + 1);
    } else {
      widget.onCompleted?.call();
    }
  }

  void _previousItem() {
    if (_currentIndex > 0) {
      _playStory(_currentIndex - 1);
    } else {
      _playStory(0);
    }
  }

  void _pause() {
    _animController.stop();
  }

  void _resume() {
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPressDown: (_) => _pause(),
      onLongPressCancel: () => _resume(),
      onLongPressEnd: (_) => _resume(),
      onTapUp: (details) {
        final box = context.findRenderObject() as RenderBox?;
        final width = box != null ? box.size.width : MediaQuery.of(context).size.width;
        final localX = box != null
            ? box.globalToLocal(details.globalPosition).dx
            : details.localPosition.dx;

        if (localX < width / 3) {
          _previousItem();
        } else {
          _nextItem();
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Story Content
          KeyedSubtree(
            key: ValueKey('story_$_currentIndex'),
            child: widget.items[_currentIndex].content,
          ),

          // Progress Bar Header
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 12,
            right: 12,
            child: Row(
              children: List.generate(widget.items.length, (index) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: _buildProgressBar(index),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(int index) {
    if (index < _currentIndex) {
      return Container(
        height: 3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
        ),
      );
    } else if (index == _currentIndex) {
      return AnimatedBuilder(
        animation: _animController,
        builder: (context, _) {
          return Container(
            height: 3,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _animController.value,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Container(
        height: 3,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(2),
        ),
      );
    }
  }
}
