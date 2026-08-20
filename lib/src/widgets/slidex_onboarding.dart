import 'package:flutter/material.dart';
import '../core/slidex_config.dart';
import '../core/slidex_controller.dart';
import '../core/slidex_enums.dart';
import '../effects/2d/slidex_2d_effects.dart';
import '../effects/slidex_effect.dart';
import 'slidex_main.dart';

/// Single Page Data Item for [SlideXOnboarding].
class SlideXOnboardingItem {
  final Widget? image;
  final String title;
  final String description;
  final Color? backgroundColor;

  const SlideXOnboardingItem({
    this.image,
    required this.title,
    required this.description,
    this.backgroundColor,
  });
}

/// Feature-Rich App Onboarding Slider Widget for SlideX with 100% Granular User Controls.
class SlideXOnboarding extends StatefulWidget {
  final List<SlideXOnboardingItem> pages;
  final VoidCallback? onFinished;
  final VoidCallback? onSkip;
  final String skipText;
  final String nextText;
  final String finishText;
  final String? headerTitle;
  final SlideXEffect effect;
  final SlideXIndicatorType indicatorType;
  final Color activeColor;
  final Color inactiveColor;
  final Color? buttonColor;
  final Color buttonTextColor;
  final Color skipTextColor;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final TextStyle? headerTextStyle;
  final BoxDecoration? cardDecoration;
  final EdgeInsets cardPadding;
  final BorderRadius borderRadius;

  const SlideXOnboarding({
    super.key,
    required this.pages,
    this.onFinished,
    this.onSkip,
    this.skipText = 'Skip',
    this.nextText = 'Next →',
    this.finishText = 'Get Started 🚀',
    this.headerTitle = 'SlideX Onboarding',
    this.effect = const ZoomEffect(),
    this.indicatorType = SlideXIndicatorType.expandingDot,
    this.activeColor = const Color(0xFF6366F1),
    this.inactiveColor = const Color(0x4DFFFFFF),
    this.buttonColor,
    this.buttonTextColor = Colors.white,
    this.skipTextColor = const Color(0xB3FFFFFF),
    this.titleStyle,
    this.descriptionStyle,
    this.headerTextStyle,
    this.cardDecoration,
    this.cardPadding = const EdgeInsets.all(24.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(32)),
  });

  @override
  State<SlideXOnboarding> createState() => _SlideXOnboardingState();
}

class _SlideXOnboardingState extends State<SlideXOnboarding> {
  late SlideXController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = SlideXController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pages.isEmpty) return const SizedBox.shrink();

    final isLastPage = _currentIndex == widget.pages.length - 1;
    final effectiveButtonColor = widget.buttonColor ?? widget.activeColor;

    return Container(
      decoration: BoxDecoration(
        color: widget.pages[_currentIndex].backgroundColor ?? Colors.transparent,
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Top Bar: Brand Header & Skip Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.headerTitle != null)
                    Text(
                      widget.headerTitle!,
                      style: widget.headerTextStyle ??
                          const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            letterSpacing: 1,
                          ),
                    )
                  else
                    const SizedBox.shrink(),
                  if (!isLastPage)
                    TextButton(
                      onPressed: () {
                        widget.onSkip?.call();
                        widget.onFinished?.call();
                      },
                      child: Text(
                        widget.skipText,
                        style: TextStyle(
                          color: widget.skipTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Onboarding Pager Viewport
            Expanded(
              child: SlideX(
                controller: _controller,
                config: const SlideXConfig(
                  loopMode: SlideXLoopMode.none,
                ),
                effect: widget.effect,
                indicatorType: widget.indicatorType,
                indicatorActiveColor: widget.activeColor,
                indicatorInactiveColor: widget.inactiveColor,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                items: List.generate(widget.pages.length, (index) {
                  final page = widget.pages[index];
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: widget.cardPadding,
                      decoration: widget.cardDecoration ??
                          BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.04),
                            borderRadius: widget.borderRadius,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.08),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: widget.activeColor.withValues(alpha: 0.2),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (page.image != null)
                            Expanded(
                              child: Center(child: page.image!),
                            ),
                          const SizedBox(height: 16),
                          Text(
                            page.title,
                            textAlign: TextAlign.center,
                            style: widget.titleStyle ??
                                const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            page.description,
                            textAlign: TextAlign.center,
                            style: widget.descriptionStyle ??
                                TextStyle(
                                  fontSize: 13,
                                  color: Colors.white.withValues(alpha: 0.7),
                                  height: 1.5,
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Bottom Action Bar: Navigation Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  // Back Button if index > 0
                  if (_currentIndex > 0)
                    IconButton.filledTonal(
                      onPressed: () {
                        _controller.previousPage();
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        padding: const EdgeInsets.all(16),
                      ),
                    ),

                  if (_currentIndex > 0) const SizedBox(width: 12),

                  // Main Next/Finish Button
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isLastPage) {
                            widget.onFinished?.call();
                          } else {
                            _controller.nextPage();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: effectiveButtonColor,
                          foregroundColor: widget.buttonTextColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 6,
                          shadowColor: effectiveButtonColor.withValues(alpha: 0.5),
                        ),
                        child: Text(
                          isLastPage ? widget.finishText : widget.nextText,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: widget.buttonTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
