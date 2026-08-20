import 'package:flutter/material.dart';

/// Swipe direction for Card Swiper.
enum SlideXSwipeDirection { left, right, up, down }

/// Controller to programmatically trigger swipe actions and rewind cards.
class SlideXCardSwiperController extends ChangeNotifier {
  _SlideXCardSwiperState? _state;

  void _attach(_SlideXCardSwiperState state) {
    _state = state;
  }

  void _detach() {
    _state = null;
  }

  /// Programmatically swipe active card to the left (NOPE).
  void swipeLeft() {
    _state?._dismissCard(SlideXSwipeDirection.left);
  }

  /// Programmatically swipe active card to the right (LIKE).
  void swipeRight() {
    _state?._dismissCard(SlideXSwipeDirection.right);
  }

  /// Programmatically rewind/undo the last swiped card.
  void rewind() {
    _state?._rewindCard();
  }
}

/// Interactive Tinder-style Card Swiper Widget for SlideX with 100% Granular User Controls.
class SlideXCardSwiper extends StatefulWidget {
  final List<Widget> cards;
  final SlideXCardSwiperController? controller;
  final ValueChanged<int>? onSwipeLeft;
  final ValueChanged<int>? onSwipeRight;
  final void Function(int index, SlideXSwipeDirection direction)? onSwiped;
  final VoidCallback? onEnd;
  final double threshold;
  final bool loop;
  final bool enableLikeNopeBadges;
  final Color likeBadgeColor;
  final Color nopeBadgeColor;
  final String likeBadgeText;
  final String nopeBadgeText;
  final TextStyle? badgeTextStyle;

  const SlideXCardSwiper({
    super.key,
    required this.cards,
    this.controller,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwiped,
    this.onEnd,
    this.threshold = 120.0,
    this.loop = true,
    this.enableLikeNopeBadges = true,
    this.likeBadgeColor = Colors.green,
    this.nopeBadgeColor = Colors.red,
    this.likeBadgeText = 'LIKE',
    this.nopeBadgeText = 'NOPE',
    this.badgeTextStyle,
  });

  @override
  State<SlideXCardSwiper> createState() => _SlideXCardSwiperState();
}

class _SlideXCardSwiperState extends State<SlideXCardSwiper>
    with SingleTickerProviderStateMixin {
  Offset _dragOffset = Offset.zero;
  int _currentIndex = 0;
  final List<int> _history = [];
  late AnimationController _animController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    widget.controller?._attach(this);
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _animController.addListener(() {
      setState(() {
        _dragOffset = _slideAnimation.value;
      });
    });
  }

  @override
  void didUpdateWidget(SlideXCardSwiper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?._detach();
      widget.controller?._attach(this);
    }
  }

  @override
  void dispose() {
    widget.controller?._detach();
    _animController.dispose();
    super.dispose();
  }

  void _dismissCard(SlideXSwipeDirection direction) {
    if (widget.cards.isEmpty) return;

    final targetX = direction == SlideXSwipeDirection.left
        ? -MediaQuery.of(context).size.width * 1.5
        : MediaQuery.of(context).size.width * 1.5;

    _slideAnimation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset(targetX, 0),
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _animController.forward(from: 0).then((_) {
      _history.add(_currentIndex);

      if (direction == SlideXSwipeDirection.left) {
        widget.onSwipeLeft?.call(_currentIndex);
      } else {
        widget.onSwipeRight?.call(_currentIndex);
      }
      widget.onSwiped?.call(_currentIndex, direction);

      setState(() {
        _dragOffset = Offset.zero;
        if (widget.loop) {
          _currentIndex = (_currentIndex + 1) % widget.cards.length;
        } else {
          _currentIndex++;
        }
      });

      if (!widget.loop && _currentIndex >= widget.cards.length) {
        widget.onEnd?.call();
      }
    });
  }

  void _rewindCard() {
    if (_history.isEmpty) return;
    setState(() {
      _currentIndex = _history.removeLast();
      _dragOffset = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cards.isEmpty ||
        (!widget.loop && _currentIndex >= widget.cards.length)) {
      return const SizedBox.shrink();
    }

    final nextIndex = (_currentIndex + 1) % widget.cards.length;
    final angle = _dragOffset.dx * 0.0008;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Background Stack Card Preview
        if (widget.cards.length > 1)
          _buildBackgroundCard(index: nextIndex, scale: 0.95, translateY: 10),

        // Active Swipable Front Card
        GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              _dragOffset += details.delta;
            });
          },
          onPanEnd: (details) {
            if (_dragOffset.dx > widget.threshold) {
              _dismissCard(SlideXSwipeDirection.right);
            } else if (_dragOffset.dx < -widget.threshold) {
              _dismissCard(SlideXSwipeDirection.left);
            } else {
              _slideAnimation =
                  Tween<Offset>(begin: _dragOffset, end: Offset.zero).animate(
                    CurvedAnimation(
                      parent: _animController,
                      curve: Curves.elasticOut,
                    ),
                  );
              _animController.forward(from: 0);
            }
          },
          child: Transform.translate(
            offset: _dragOffset,
            child: Transform.rotate(
              angle: angle,
              child: Stack(
                children: [
                  widget.cards[_currentIndex % widget.cards.length],

                  // Animated LIKE Badge
                  if (widget.enableLikeNopeBadges && _dragOffset.dx > 40)
                    Positioned(
                      top: 40,
                      left: 40,
                      child: Transform.rotate(
                        angle: -0.2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.likeBadgeColor,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color: widget.likeBadgeColor.withValues(alpha: 0.2),
                          ),
                          child: Text(
                            widget.likeBadgeText,
                            style:
                                widget.badgeTextStyle ??
                                TextStyle(
                                  color: widget.likeBadgeColor,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                          ),
                        ),
                      ),
                    ),

                  // Animated NOPE Badge
                  if (widget.enableLikeNopeBadges && _dragOffset.dx < -40)
                    Positioned(
                      top: 40,
                      right: 40,
                      child: Transform.rotate(
                        angle: 0.2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.nopeBadgeColor,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color: widget.nopeBadgeColor.withValues(alpha: 0.2),
                          ),
                          child: Text(
                            widget.nopeBadgeText,
                            style:
                                widget.badgeTextStyle ??
                                TextStyle(
                                  color: widget.nopeBadgeColor,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundCard({
    required int index,
    required double scale,
    required double translateY,
  }) {
    return Transform.translate(
      offset: Offset(0, translateY),
      child: Transform.scale(scale: scale, child: widget.cards[index]),
    );
  }
}
