import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slidex/slidex.dart';

void main() {
  group('SlideX Controller Tests', () {
    test('initial state and page index management', () {
      final controller = SlideXController();
      expect(controller.currentPage, equals(0));
      expect(controller.isAutoPlaying, isFalse);
    });

    test('attach and update configuration', () {
      final controller = SlideXController();
      final pageController = PageController();
      const config = SlideXConfig(autoPlay: false);

      controller.attach(
        pageController: pageController,
        itemCount: 5,
        config: config,
        initialPage: 2,
      );

      expect(controller.currentPage, equals(2));
      expect(controller.itemCount, equals(5));
    });
  });

  group('SlideX Widget Tests', () {
    testWidgets('renders SlideX basic widget without crashing', (tester) async {
      final items = List.generate(
        3,
        (i) => Container(
          key: ValueKey('item_$i'),
          color: Colors.blue,
          child: Text('Slide $i'),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlideX(
              items: items,
            ),
          ),
        ),
      );

      expect(find.text('Slide 0'), findsOneWidget);
    });

    testWidgets('renders SlideX.carousel constructor', (tester) async {
      final items = [
        const Text('Banner 1'),
        const Text('Banner 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlideX.carousel(
              items: items,
              autoPlay: false,
            ),
          ),
        ),
      );

      expect(find.text('Banner 1'), findsOneWidget);
    });

    testWidgets('renders SlideX.story constructor and advances to next story on tap', (tester) async {
      final storyItems = [
        const SlideXStoryItem(
          content: Text('Story Item 1'),
          duration: Duration(seconds: 2),
        ),
        const SlideXStoryItem(
          content: Text('Story Item 2'),
          duration: Duration(seconds: 2),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlideX.story(
              items: storyItems,
            ),
          ),
        ),
      );

      expect(find.text('Story Item 1'), findsOneWidget);

      // Tap on right side to advance to next story
      await tester.tap(find.byType(SlideXStoryView));
      await tester.pump();

      expect(find.text('Story Item 2'), findsOneWidget);
    });

    testWidgets('renders SlideX.gallery constructor with thumbnails strip', (tester) async {
      final galleryItems = [
        const Text('Product Image 1'),
        const Text('Product Image 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlideX.gallery(
              items: galleryItems,
            ),
          ),
        ),
      );

      expect(find.text('Product Image 1'), findsWidgets);
    });

    testWidgets('renders SlideX.cardSwipe Tinder-style card stack swiper', (tester) async {
      final cards = [
        const Text('Card 1'),
        const Text('Card 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlideX.cardSwipe(
              cards: cards,
            ),
          ),
        ),
      );

      expect(find.text('Card 1'), findsWidgets);
    });

    testWidgets('renders SlideX.imageSlider with captions and badge overlay', (tester) async {
      final images = [
        const SlideXImageData(
          image: AssetImage('assets/test.png'),
          title: 'Hero Title',
          subtitle: 'Hero Subtitle',
          badge: 'FEATURED',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlideX.imageSlider(
              images: images,
              autoPlay: false,
            ),
          ),
        ),
      );

      expect(find.text('Hero Title'), findsOneWidget);
      expect(find.text('FEATURED'), findsOneWidget);
    });

    testWidgets('renders SlideX.product360 interactive 360 degree rotation viewer', (tester) async {
      final transparentPixel = Uint8List.fromList([
        0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
        0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
        0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
        0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
        0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
        0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
      ]);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlideX.product360(
              imageList: [
                MemoryImage(transparentPixel),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Drag to Rotate 360°'), findsOneWidget);
    });

    testWidgets('renders SlideX.onboarding slider with Skip and Next buttons', (tester) async {
      final pages = [
        const SlideXOnboardingItem(
          title: 'Welcome to SlideX',
          description: '120 FPS Motion Engine Framework',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: SlideXOnboarding(
            pages: pages,
          ),
        ),
      );

      expect(find.text('Welcome to SlideX'), findsOneWidget);
      expect(find.text('Get Started 🚀'), findsOneWidget);
    });

    testWidgets('renders SlideX.vertical slider with vertical chevrons', (tester) async {
      final items = [
        const Text('Vertical Slide 1'),
        const Text('Vertical Slide 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlideX.vertical(
              items: items,
            ),
          ),
        ),
      );

      expect(find.text('Vertical Slide 1'), findsWidgets);
    });

    testWidgets('renders SlideXItem.image, SlideXItem.video, and SlideXItem.child items', (tester) async {
      final transparentPixel = Uint8List.fromList([
        0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
        0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
        0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
        0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
        0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
        0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
      ]);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlideX(
              items: [
                SlideXItem.image(
                  MemoryImage(transparentPixel),
                  title: 'Image Item',
                ),
                SlideXItem.video(
                  const Icon(Icons.video_collection),
                  title: 'Video Item',
                  durationText: '02:45',
                ),
                SlideXItem.child(
                  const Text('Custom Child Widget'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Image Item'), findsOneWidget);
    });
  });
}
