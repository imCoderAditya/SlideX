import '../core/slidex_config.dart';
import '../core/slidex_enums.dart';
import '../effects/2d/slidex_2d_effects.dart';
import '../effects/3d/slidex_3d_effects.dart';
import '../effects/slidex_effect.dart';

/// Pre-configured template preset configuration for SlideX.
class SlideXTemplatePreset {
  final String name;
  final String category;
  final SlideXConfig config;
  final SlideXEffect effect;
  final SlideXIndicatorType indicatorType;

  const SlideXTemplatePreset({
    required this.name,
    required this.category,
    required this.config,
    required this.effect,
    this.indicatorType = SlideXIndicatorType.dot,
  });
}

/// Collection of production template presets for SlideX.
class SlideXTemplates {
  // 1. BASIC TEMPLATES
  static const basicStandard = SlideXTemplatePreset(
    name: 'Basic Standard',
    category: 'Basic',
    config: SlideXConfig(),
    effect: SlideEffect(),
  );

  static const basicFade = SlideXTemplatePreset(
    name: 'Basic Fade',
    category: 'Basic',
    config: SlideXConfig(),
    effect: FadeEffect(),
  );

  static const basicZoom = SlideXTemplatePreset(
    name: 'Basic Zoom',
    category: 'Basic',
    config: SlideXConfig(),
    effect: ZoomEffect(),
  );

  // 2. SOCIAL MEDIA TEMPLATES
  static const instagramFeed = SlideXTemplatePreset(
    name: 'Instagram Feed Carousel',
    category: 'Social Media',
    config: SlideXConfig(autoPlay: false, enableGestures: true),
    effect: SlideEffect(),
    indicatorType: SlideXIndicatorType.dot,
  );

  static const tiktokVertical = SlideXTemplatePreset(
    name: 'TikTok Vertical Scroll',
    category: 'Social Media',
    config: SlideXConfig(
      scrollDirection: SlideXAxis.vertical,
      viewportFraction: 1.0,
      autoPlay: false,
    ),
    effect: SlideEffect(),
  );

  static const snapchatStory = SlideXTemplatePreset(
    name: 'Snapchat Story Cube',
    category: 'Social Media',
    config: SlideXConfig(autoPlay: false),
    effect: CubeEffect(),
  );

  // 3. ECOMMERCE TEMPLATES
  static const productCardZoom = SlideXTemplatePreset(
    name: 'E-commerce Product Zoom',
    category: 'Ecommerce',
    config: SlideXConfig(viewportFraction: 0.85),
    effect: ZoomEffect(zoomScale: 0.9),
    indicatorType: SlideXIndicatorType.expandingDot,
  );

  static const flashSaleBanner = SlideXTemplatePreset(
    name: 'Flash Sale Parallax Banner',
    category: 'Ecommerce',
    config: SlideXConfig(autoPlay: true, autoPlayInterval: Duration(seconds: 4)),
    effect: ParallaxEffect(),
    indicatorType: SlideXIndicatorType.progressLine,
  );

  // 4. OTT / STREAMING TEMPLATES
  static const netflixHeroCoverflow = SlideXTemplatePreset(
    name: 'Netflix Movie Coverflow',
    category: 'OTT/Streaming',
    config: SlideXConfig(viewportFraction: 0.75, autoPlay: true),
    effect: CoverflowEffect(depth: 100),
    indicatorType: SlideXIndicatorType.number,
  );

  static const spotifyAlbumWheel = SlideXTemplatePreset(
    name: 'Spotify Album Wheel',
    category: 'OTT/Streaming',
    config: SlideXConfig(viewportFraction: 0.7),
    effect: WheelEffect(),
  );

  // 5. NEWS & MEDIA TEMPLATES
  static const newsHeadlineTicker = SlideXTemplatePreset(
    name: 'News Breaking Ticker',
    category: 'News',
    config: SlideXConfig(
      scrollDirection: SlideXAxis.vertical,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
    ),
    effect: FadeEffect(),
  );

  // 6. TRAVEL TEMPLATES
  static const destinationCards = SlideXTemplatePreset(
    name: 'Destination Parallax Cards',
    category: 'Travel',
    config: SlideXConfig(viewportFraction: 0.8),
    effect: ParallaxEffect(parallaxFactor: 0.7),
    indicatorType: SlideXIndicatorType.expandingDot,
  );

  // 7. FOOD TEMPLATES
  static const recipeCarousel = SlideXTemplatePreset(
    name: 'Recipe Bounce Carousel',
    category: 'Food',
    config: SlideXConfig(viewportFraction: 0.85),
    effect: BounceEffect(),
  );

  // 8. PRODUCT SHOWCASE TEMPLATES
  static const productSphere3D = SlideXTemplatePreset(
    name: '3D Product Sphere Showcase',
    category: 'Product Showcase',
    config: SlideXConfig(viewportFraction: 0.75),
    effect: SphereEffect(),
  );

  // 9. CARDS TEMPLATES
  static const stack3DCards = SlideXTemplatePreset(
    name: '3D Stacked Card Deck',
    category: 'Cards',
    config: SlideXConfig(viewportFraction: 0.85),
    effect: Stack3DEffect(),
  );

  // 10. PREMIUM TEMPLATES
  static const glassmorphicLiquid = SlideXTemplatePreset(
    name: 'Glassmorphic Liquid Wave',
    category: 'Premium',
    config: SlideXConfig(viewportFraction: 0.9),
    effect: LiquidEffect(),
  );

  // 11. STORY TEMPLATES
  static const fullStoryCube = SlideXTemplatePreset(
    name: 'Full Screen Story Cube',
    category: 'Story',
    config: SlideXConfig(viewportFraction: 1.0),
    effect: CubeEffect(),
  );

  // 12. GALLERY TEMPLATES
  static const lightboxGallery = SlideXTemplatePreset(
    name: 'Lightbox Scale Gallery',
    category: 'Gallery',
    config: SlideXConfig(viewportFraction: 0.9),
    effect: ScaleEffect(),
  );

  // 13. MARKETING TEMPLATES
  static const onboardingElastic = SlideXTemplatePreset(
    name: 'Onboarding Elastic Pager',
    category: 'Marketing',
    config: SlideXConfig(viewportFraction: 1.0),
    effect: ElasticEffect(),
    indicatorType: SlideXIndicatorType.expandingDot,
  );

  // 14. 3D SPECIAL EFFECTS TEMPLATES
  static const tunnelWarp = SlideXTemplatePreset(
    name: 'Warp Speed Tunnel 3D',
    category: '3D',
    config: SlideXConfig(viewportFraction: 0.7),
    effect: TunnelEffect(),
  );

  static const infinityLoop3D = SlideXTemplatePreset(
    name: 'Infinity Loop 3D Path',
    category: '3D',
    config: SlideXConfig(viewportFraction: 0.75),
    effect: InfinityLoopEffect(),
  );

  /// Map of all available preset templates.
  static const List<SlideXTemplatePreset> all = [
    basicStandard,
    basicFade,
    basicZoom,
    instagramFeed,
    tiktokVertical,
    snapchatStory,
    productCardZoom,
    flashSaleBanner,
    netflixHeroCoverflow,
    spotifyAlbumWheel,
    newsHeadlineTicker,
    destinationCards,
    recipeCarousel,
    productSphere3D,
    stack3DCards,
    glassmorphicLiquid,
    fullStoryCube,
    lightboxGallery,
    onboardingElastic,
    tunnelWarp,
    infinityLoop3D,
  ];
}
