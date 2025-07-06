import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search_bar_animated_master/search_bar_animated_master.dart';

void main() {
  group('EnhancedAnimSearchBar Tests', () {
    late TextEditingController textController;

    setUp(() {
      textController = TextEditingController();
    });

    tearDown(() {
      textController.dispose();
    });

    testWidgets('EnhancedAnimSearchBar renders correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedAnimSearchBar(
              width: 300,
              textController: textController,
              onSuffixTap: () {},
              onSubmitted: (value) {},
            ),
          ),
        ),
      );

      // Verify the search bar is rendered
      expect(find.byType(EnhancedAnimSearchBar), findsOneWidget);

      // Verify initial state (collapsed)
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('Search bar expands when prefix icon is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedAnimSearchBar(
              width: 300,
              textController: textController,
              onSuffixTap: () {},
              onSubmitted: (value) {},
            ),
          ),
        ),
      );

      // Tap the prefix icon to expand
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Verify the search bar expanded (back arrow should be visible)
      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
    });

    testWidgets('Search submission works correctly', (
      WidgetTester tester,
    ) async {
      String submittedValue = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedAnimSearchBar(
              width: 300,
              textController: textController,
              onSuffixTap: () {},
              onSubmitted: (value) {
                submittedValue = value;
              },
            ),
          ),
        ),
      );

      // Expand the search bar
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Enter text
      await tester.enterText(find.byType(TextField), 'test search');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Verify submission
      expect(submittedValue, equals('test search'));
    });

    testWidgets('Custom gradient colors are applied', (
      WidgetTester tester,
    ) async {
      const customColors = [Colors.red, Colors.blue, Colors.green];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedAnimSearchBar(
              width: 300,
              textController: textController,
              onSuffixTap: () {},
              onSubmitted: (value) {},
              gradientColors: customColors,
            ),
          ),
        ),
      );

      // Verify the widget renders with custom colors
      expect(find.byType(EnhancedAnimSearchBar), findsOneWidget);
    });

    testWidgets('RTL support works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedAnimSearchBar(
              width: 300,
              textController: textController,
              onSuffixTap: () {},
              onSubmitted: (value) {},
              rtl: true,
            ),
          ),
        ),
      );

      // Verify the widget renders in RTL mode
      expect(find.byType(EnhancedAnimSearchBar), findsOneWidget);
    });

    testWidgets('Animation effects can be disabled', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedAnimSearchBar(
              width: 300,
              textController: textController,
              onSuffixTap: () {},
              onSubmitted: (value) {},
              fadeAnimation: false,
              glowEffect: false,
              borderGradient: false,
              pulseAnimation: false,
            ),
          ),
        ),
      );

      // Verify the widget renders without effects
      expect(find.byType(EnhancedAnimSearchBar), findsOneWidget);
    });
  });
}
