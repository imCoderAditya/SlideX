import 'dart:async';
import 'package:flutter/widgets.dart';
import 'slidex_config.dart';

/// Interactive controller for managing [SlideX] state, page transitions, and auto-play timers.
class SlideXController extends ChangeNotifier {
  /// Internal PageController instance.
  PageController? _pageController;

  /// Current active page index (0-indexed).
  int _currentPage = 0;

  /// Total count of items.
  int _itemCount = 0;

  /// AutoPlay timer reference.
  Timer? _autoPlayTimer;

  /// Active configuration.
  SlideXConfig _config = const SlideXConfig();

  /// Whether auto-play is actively running.
  bool _isAutoPlaying = false;

  /// Page offset value (e.g., 2.3 means between index 2 and 3).
  double _pageOffset = 0.0;

  /// Current page index getter.
  int get currentPage => _currentPage;

  /// Total item count getter.
  int get itemCount => _itemCount;

  /// Whether auto-play is running.
  bool get isAutoPlaying => _isAutoPlaying;

  /// Exact page scroll offset.
  double get pageOffset => _pageOffset;

  /// Underlying Flutter PageController.
  PageController? get pageController => _pageController;

  /// Initialize controller with configuration and item count.
  void attach({
    required PageController pageController,
    required int itemCount,
    required SlideXConfig config,
    int initialPage = 0,
  }) {
    _pageController = pageController;
    _itemCount = itemCount;
    _config = config;
    _currentPage = initialPage;

    if (_config.autoPlay) {
      startAutoPlay();
    }
  }

  /// Update page offset stream from scroll updates.
  void updatePageOffset(double offset, int page) {
    _pageOffset = offset;
    if (_currentPage != page) {
      _currentPage = page;
      notifyListeners();
    }
  }

  /// Transition to next slide item.
  Future<void> nextPage({Duration? duration, Curve? curve}) async {
    if (_pageController == null || _itemCount == 0) return;
    final targetPage = (_currentPage + 1) % _itemCount;
    await animateToPage(targetPage, duration: duration, curve: curve);
  }

  /// Transition to previous slide item.
  Future<void> previousPage({Duration? duration, Curve? curve}) async {
    if (_pageController == null || _itemCount == 0) return;
    final targetPage = (_currentPage - 1 + _itemCount) % _itemCount;
    await animateToPage(targetPage, duration: duration, curve: curve);
  }

  /// Animate smoothly to specific page index.
  Future<void> animateToPage(int page, {Duration? duration, Curve? curve}) async {
    if (_pageController == null || !_pageController!.hasClients) return;
    _currentPage = page.clamp(0, _itemCount - 1);
    await _pageController!.animateToPage(
      _currentPage,
      duration: duration ?? _config.animationDuration,
      curve: curve ?? _config.animationCurve,
    );
    notifyListeners();
  }

  /// Jump instantly to specific page index without animation.
  void jumpToPage(int page) {
    if (_pageController == null || !_pageController!.hasClients) return;
    _currentPage = page.clamp(0, _itemCount - 1);
    _pageController!.jumpToPage(_currentPage);
    notifyListeners();
  }

  /// Start auto-play slideshow timer.
  void startAutoPlay() {
    stopAutoPlay();
    if (_itemCount <= 1) return;
    _isAutoPlaying = true;
    _autoPlayTimer = Timer.periodic(_config.autoPlayInterval, (_) {
      nextPage();
    });
    notifyListeners();
  }

  /// Stop/Pause auto-play slideshow timer.
  void stopAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
    _isAutoPlaying = false;
    notifyListeners();
  }

  /// Temporarily pause auto-play (e.g. on user touch/drag gesture).
  void pause() => stopAutoPlay();

  /// Resume auto-play (e.g. on gesture release).
  void resume() {
    if (_config.autoPlay) {
      startAutoPlay();
    }
  }

  @override
  void dispose() {
    stopAutoPlay();
    super.dispose();
  }
}
