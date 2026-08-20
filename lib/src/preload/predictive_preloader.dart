import 'package:flutter/widgets.dart';

/// Predictive image preloading engine for zero-flicker slide transitions.
class SlideXPreloader {
  /// Precache adjacent image providers (index - 1, index + 1).
  static void precacheImages({
    required BuildContext context,
    required List<ImageProvider> providers,
    required int currentIndex,
  }) {
    if (providers.isEmpty) return;

    final indicesToPrecache = {
      (currentIndex - 1 + providers.length) % providers.length,
      currentIndex,
      (currentIndex + 1) % providers.length,
    };

    for (final index in indicesToPrecache) {
      if (index >= 0 && index < providers.length) {
        precacheImage(providers[index], context);
      }
    }
  }
}
