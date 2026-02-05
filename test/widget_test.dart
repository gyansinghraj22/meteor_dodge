// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flame/game.dart';

import 'package:meteor_dodge/meteor_dodge_game.dart';

void main() {
  testWidgets('Game loads correctly', (WidgetTester tester) async {
    // Build our game widget and trigger a frame.
    await tester.pumpWidget(GameWidget(game: MeteorDodgeGame()));

    // Verify that the game widget is present
    expect(find.byType(GameWidget), findsOneWidget);
  });
}
