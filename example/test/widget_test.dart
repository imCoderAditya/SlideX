import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  testWidgets('SlideX Showcase App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SlideXShowcaseApp());
    expect(find.text('SlideX Engine'), findsOneWidget);
  });
}
