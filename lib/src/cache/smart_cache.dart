import 'package:flutter/widgets.dart';

/// Memory-optimized Smart Cache pool for SlideX widget recycling.
class SlideXSmartCache {
  final int maxCacheSize;
  final Map<int, Widget> _cache = {};

  SlideXSmartCache({this.maxCacheSize = 10});

  /// Retrieve cached widget for index if present.
  Widget? get(int index) => _cache[index];

  /// Store widget in memory cache pool.
  void put(int index, Widget widget) {
    if (_cache.length >= maxCacheSize && !_cache.containsKey(index)) {
      final firstKey = _cache.keys.first;
      _cache.remove(firstKey);
    }
    _cache[index] = widget;
  }

  /// Clear memory cache pool.
  void clear() => _cache.clear();
}
