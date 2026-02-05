import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:meteor_dodge/meteor_dodge_game.dart';

class Player extends PositionComponent
    with HasGameReference<MeteorDodgeGame>, DragCallbacks {
  Player(Vector2 gameSize)
    : super(
        size: Vector2(60, 60),
        position: Vector2(gameSize.x / 2 - 30, gameSize.y - 90),
      );

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    // Move player with drag delta
    position.add(event.localDelta);

    // Keep player inside screen bounds
    position.x = position.x.clamp(0, game.size.x - size.x);
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFF00FFAA);
    canvas.drawRect(size.toRect(), paint);
  }
}
