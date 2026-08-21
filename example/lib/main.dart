/// SlideX Showcase App — 120 FPS Motion Engine & Carousel Framework for Flutter.
import 'package:flutter/material.dart';
import 'package:slidex/slidex.dart';

void main() {
  runApp(const SlideXShowcaseApp());
}

class SlideXShowcaseApp extends StatelessWidget {
  const SlideXShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SlideX Motion Engine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: const Color(0xFF090D16),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6366F1),
          secondary: Color(0xFFEC4899),
          surface: Color(0xFF1E293B),
        ),
      ),
      home: const ShowcaseHomeScreen(),
    );
  }
}

class ShowcaseHomeScreen extends StatefulWidget {
  const ShowcaseHomeScreen({super.key});

  @override
  State<ShowcaseHomeScreen> createState() => _ShowcaseHomeScreenState();
}

class _ShowcaseHomeScreenState extends State<ShowcaseHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late SlideXController _controller;
  late SlideXCardSwiperController _cardSwiperController;

  SlideXEffect _selectedEffect = const CoverflowEffect();
  SlideXIndicatorType _indicatorType = SlideXIndicatorType.expandingDot;
  bool _autoPlay = false;
  final double _viewportFraction = 0.82;

  final List<SlideData> _slides = [
    const SlideData(
      title: 'Cosmic Voyage',
      category: 'Sci-Fi • 6K',
      rating: '4.9 ★',
      gradient: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
      icon: Icons.rocket_launch,
    ),
    const SlideData(
      title: 'Neon Cyberpunk',
      category: 'Action • Motion',
      rating: '4.8 ★',
      gradient: [Color(0xFFEC4899), Color(0xFF8B5CF6)],
      icon: Icons.electric_bolt,
    ),
    const SlideData(
      title: 'Emerald Horizon',
      category: 'Nature • 8K',
      rating: '5.0 ★',
      gradient: [Color(0xFF10B981), Color(0xFF059669)],
      icon: Icons.landscape,
    ),
    const SlideData(
      title: 'Sunset Dreams',
      category: 'Ambient • Lo-Fi',
      rating: '4.7 ★',
      gradient: [Color(0xFFF59E0B), Color(0xFFEF4444)],
      icon: Icons.wb_sunny,
    ),
    const SlideData(
      title: 'Quantum Realm',
      category: 'Tech • 3D',
      rating: '4.9 ★',
      gradient: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
      icon: Icons.blur_on,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _controller = SlideXController();
    _cardSwiperController = SlideXCardSwiperController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    _cardSwiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF090D16), Color(0xFF0F172A), Color(0xFF1E1B4B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header App Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6366F1)
                                    .withValues(alpha: 0.4),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.style,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'SlideX Engine',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              '120 FPS Motion Framework',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.15),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.bolt, color: Color(0xFF10B981), size: 14),
                          SizedBox(width: 4),
                          Text(
                            'v1.0 Ready',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Tab Bar Navigation
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicator: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white54,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.view_carousel, size: 18),
                      text: 'Carousel',
                    ),
                    Tab(
                      icon: Icon(Icons.swipe_left, size: 18),
                      text: 'Card Swipe',
                    ),
                    Tab(
                      icon: Icon(Icons.amp_stories, size: 18),
                      text: 'Stories',
                    ),
                    Tab(
                      icon: Icon(Icons.rocket_launch, size: 18),
                      text: 'Onboarding',
                    ),
                    Tab(
                      icon: Icon(Icons.swap_vert, size: 18),
                      text: 'Vertical',
                    ),
                    Tab(icon: Icon(Icons.grid_on, size: 18), text: 'Gallery'),
                    Tab(
                      icon: Icon(Icons.collections, size: 18),
                      text: 'Presets',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Tab Views
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildCarouselTab(),
                    _buildCardSwipeTab(),
                    _buildStoriesTab(),
                    _buildOnboardingTab(),
                    _buildVerticalTab(),
                    _buildGalleryTab(),
                    _buildPresetsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // TAB 1: CAROUSEL & 3D/2D MOTION EFFECTS PLAYGROUND
  // -------------------------------------------------------------
  Widget _buildCarouselTab() {
    return Column(
      children: [
        const SizedBox(height: 10),

        // SlideX Motion Viewport
        SizedBox(
          height: 330,
          child: SlideX(
            controller: _controller,
            config: SlideXConfig(
              viewportFraction: _viewportFraction,
              autoPlay: _autoPlay,
              loopMode: SlideXLoopMode.infinite,
            ),
            effect: _selectedEffect,
            indicatorType: _indicatorType,
            indicatorActiveColor: const Color(0xFFEC4899),
            indicatorInactiveColor: Colors.white.withValues(alpha: 0.3),
            items: [
              SlideXItem.video(
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.movie_creation,
                      size: 100,
                      color: Colors.white30,
                    ),
                  ),
                ),
                title: 'Cosmic Voyage (4K Trailer)',
                durationText: '02:45',
                isPlaying: false,
                onPlayTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Playing Cosmic Voyage Video... 🎬'),
                    ),
                  );
                },
              ),
              SlideXItem.image(
                const NetworkImage(
                  'https://images.unsplash.com/photo-1518709268805-4e9042af9f23',
                ),
                title: 'Neon Cyberpunk City',
                subtitle: 'Sci-Fi • 6K Wallpaper',
              ),
              SlideXItem.child(
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF059669)],
                    ),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.widgets, size: 64, color: Colors.white),
                      SizedBox(height: 12),
                      Text(
                        'Custom Child Widget',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Controls Action Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filledTonal(
                onPressed: () => _controller.previousPage(),
                icon: const Icon(Icons.chevron_left, size: 24),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() => _autoPlay = !_autoPlay);
                  if (_autoPlay) {
                    _controller.startAutoPlay();
                  } else {
                    _controller.stopAutoPlay();
                  }
                },
                icon: Icon(
                  _autoPlay ? Icons.pause_circle : Icons.play_circle,
                  color: Colors.white,
                ),
                label: Text(_autoPlay ? 'Pause' : 'Auto Play'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              IconButton.filledTonal(
                onPressed: () => _controller.nextPage(),
                icon: const Icon(Icons.chevron_right, size: 24),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Interactive Effects Picker Grid
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
            ),
            child: ListView(
              children: [
                const Row(
                  children: [
                    Icon(Icons.view_in_ar, size: 18, color: Color(0xFFEC4899)),
                    SizedBox(width: 8),
                    Text(
                      '3D Perspective Effects',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _effectChip('Coverflow 3D', const CoverflowEffect()),
                    _effectChip('Cube 3D', const CubeEffect()),
                    _effectChip('Sphere 3D', const SphereEffect()),
                    _effectChip('Wheel 3D', const WheelEffect()),
                    _effectChip('Cylinder 3D', const CylinderEffect()),
                    _effectChip('Stack 3D', const Stack3DEffect()),
                    _effectChip('Tunnel 3D', const TunnelEffect()),
                    _effectChip('Infinity 3D', const InfinityLoopEffect()),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(Icons.animation, size: 18, color: Color(0xFF6366F1)),
                    SizedBox(width: 8),
                    Text(
                      '2D Motion Effects',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _effectChip('Zoom', const ZoomEffect()),
                    _effectChip('Scale', const ScaleEffect()),
                    _effectChip('Blur', const BlurEffect()),
                    _effectChip('Parallax', const ParallaxEffect()),
                    _effectChip('Elastic', const ElasticEffect()),
                    _effectChip('Bounce', const BounceEffect()),
                    _effectChip('Liquid', const LiquidEffect()),
                    _effectChip('Curtain', const CurtainEffect()),
                    _effectChip('Morph', const MorphEffect()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------
  // TAB 2: TINDER-STYLE CARD SWIPE STACK
  // -------------------------------------------------------------
  Widget _buildCardSwipeTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 320,
          height: 420,
          child: SlideX.cardSwipe(
            controller: _cardSwiperController,
            cards: _slides.map((item) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: item.gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: item.gradient.first.withValues(alpha: 0.45),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      bottom: -20,
                      child: Icon(item.icon, size: 160, color: Colors.white12),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  item.category,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Text(
                                item.rating,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(item.icon, size: 56, color: Colors.white),
                              const SizedBox(height: 12),
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Drag Left ← NOPE | Drag Right → LIKE',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),

        // Action Control Buttons: NOPE | REWIND | LIKE
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // NOPE Button
            IconButton.filled(
              onPressed: () => _cardSwiperController.swipeLeft(),
              icon: const Icon(Icons.close, color: Colors.redAccent, size: 28),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                padding: const EdgeInsets.all(16),
                side: const BorderSide(color: Colors.redAccent, width: 2),
              ),
            ),
            const SizedBox(width: 24),

            // REWIND Button
            IconButton.filled(
              onPressed: () => _cardSwiperController.rewind(),
              icon: const Icon(Icons.refresh, color: Colors.amber, size: 24),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                padding: const EdgeInsets.all(12),
                side: const BorderSide(color: Colors.amber, width: 2),
              ),
            ),
            const SizedBox(width: 24),

            // LIKE Button
            IconButton.filled(
              onPressed: () => _cardSwiperController.swipeRight(),
              icon: const Icon(
                Icons.favorite,
                color: Colors.greenAccent,
                size: 28,
              ),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                padding: const EdgeInsets.all(16),
                side: const BorderSide(color: Colors.greenAccent, width: 2),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _effectChip(String label, SlideXEffect effect) {
    final isSelected = _selectedEffect.runtimeType == effect.runtimeType;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: const Color(0xFF6366F1),
      backgroundColor: Colors.white.withValues(alpha: 0.06),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.white70,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: 12,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (_) {
        setState(() => _selectedEffect = effect);
      },
    );
  }

  // -------------------------------------------------------------
  // TAB 3: INSTAGRAM/SNAPCHAT STYLE STORY VIEWER
  // -------------------------------------------------------------
  Widget _buildStoriesTab() {
    return Center(
      child: Container(
        width: 350,
        height: 580,
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.15),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SlideX.story(
            items: [
              SlideXStoryItem(
                content: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.touch_app, size: 64, color: Colors.white),
                          SizedBox(height: 20),
                          Text(
                            'Interactive Story Viewer',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Tap Right → Next Story\nTap Left ← Previous Story\nLong Press → Pause Story',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SlideXStoryItem(
                content: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFEC4899), Color(0xFFF43F5E)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.speed, size: 64, color: Colors.white),
                        SizedBox(height: 20),
                        Text(
                          '120 FPS Motion Engine',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SlideXStoryItem(
                content: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF059669)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.memory, size: 64, color: Colors.white),
                        SizedBox(height: 20),
                        Text(
                          'Zero Dependency & Smart Caching',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            onCompleted: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Stories finished! Tap to replay.'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // TAB 4: APP ONBOARDING SLIDER (SHOWCASE SCREEN 1 & 7)
  // -------------------------------------------------------------
  Widget _buildOnboardingTab() {
    final pages = [
      SlideXOnboardingItem(
        image: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6366F1).withValues(alpha: 0.5),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(Icons.rocket_launch, size: 90, color: Colors.white),
        ),
        title: 'Boost Your App',
        description: 'Beautiful UI • Smooth Motion • Infinite Possibilities',
      ),
      SlideXOnboardingItem(
        image: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFFEC4899), Color(0xFFF43F5E)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFEC4899).withValues(alpha: 0.5),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(Icons.bolt, size: 90, color: Colors.white),
        ),
        title: '120 FPS Motion Engine',
        description: 'Tuned spring physics with zero drop frames',
      ),
      SlideXOnboardingItem(
        image: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF059669)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10B981).withValues(alpha: 0.5),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(Icons.view_in_ar, size: 90, color: Colors.white),
        ),
        title: '27+ 2D/3D Transitions',
        description: 'Coverflow, Cube, Sphere, Liquid, Bounce & Morph',
      ),
    ];

    return SlideXOnboarding(
      pages: pages,
      activeColor: const Color(0xFF6366F1),
      onFinished: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Onboarding finished! Welcome to SlideX 🚀'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }

  // -------------------------------------------------------------
  // TAB 5: DEDICATED VERTICAL SLIDER (SHOWCASE SCREEN 9)
  // -------------------------------------------------------------
  Widget _buildVerticalTab() {
    final items = [
      _buildVerticalCard(
        'City Lights',
        'Urban Vibes • Nightlife',
        const Color(0xFF6366F1),
        Icons.location_city,
      ),
      _buildVerticalCard(
        'Ocean View',
        'Beach Life • Tropical',
        const Color(0xFF06B6D4),
        Icons.water,
      ),
      _buildVerticalCard(
        'Green Hills',
        'Nature Peace • 8K',
        const Color(0xFF10B981),
        Icons.forest,
      ),
    ];

    return Center(
      child: Container(
        width: 350,
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: SlideX.vertical(
          height: 480,
          effect: const SlideEffect(),
          items: items,
        ),
      ),
    );
  }

  Widget _buildVerticalCard(
    String title,
    String subtitle,
    Color color,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.65)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, size: 36, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.play_circle_fill,
                size: 36,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // TAB 6: PRODUCT MEDIA GALLERY
  // -------------------------------------------------------------
  Widget _buildGalleryTab() {
    final products = [
      const ProductData(
        'Cyber Headphones',
        '\$299',
        Icons.headphones,
        Color(0xFF6366F1),
      ),
      const ProductData(
        'Smart Watch Pro',
        '\$499',
        Icons.watch,
        Color(0xFFEC4899),
      ),
      const ProductData(
        'DSLR Cinema Cam',
        '\$1,299',
        Icons.camera_alt,
        Color(0xFF10B981),
      ),
      const ProductData(
        'VR Vision Goggles',
        '\$899',
        Icons.view_in_ar,
        Color(0xFFA855F7),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SlideX.gallery(
        thumbnailHeight: 80,
        effect: const ScaleEffect(),
        items: List.generate(products.length, (index) {
          final item = products[index];
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [item.color, item.color.withValues(alpha: 0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: item.color.withValues(alpha: 0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                Center(child: Icon(item.icon, size: 120, color: Colors.white)),
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        item.price,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // -------------------------------------------------------------
  // TAB 7: PRESETS BROWSER
  // -------------------------------------------------------------
  Widget _buildPresetsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: SlideXTemplates.all.length,
      itemBuilder: (context, index) {
        final preset = SlideXTemplates.all[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Material(
            color: Colors.white.withValues(alpha: 0.05),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
            ),
            clipBehavior: Clip.none,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              hoverColor: const Color(0xFF6366F1).withValues(alpha: 0.15),
              splashColor: const Color(0xFFEC4899).withValues(alpha: 0.2),
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF6366F1),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                preset.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                'Category: ${preset.category} • Effect: ${preset.effect.runtimeType}',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 12,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.white54,
              ),
              onTap: () {
                setState(() {
                  _selectedEffect = preset.effect;
                  _indicatorType = preset.indicatorType;
                  _tabController.animateTo(0);
                });
              },
            ),
          ),
        );
      },
    );
  }
}

class SlideData {
  final String title;
  final String category;
  final String rating;
  final List<Color> gradient;
  final IconData icon;

  const SlideData({
    required this.title,
    required this.category,
    required this.rating,
    required this.gradient,
    required this.icon,
  });
}

class ProductData {
  final String name;
  final String price;
  final IconData icon;
  final Color color;

  const ProductData(this.name, this.price, this.icon, this.color);
}
