import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'meteor_dodge_game.dart';
import 'player.dart';

class Meteor extends PositionComponent
    with HasGameReference<MeteorDodgeGame>, CollisionCallbacks {
  double speed;

  Meteor({required Vector2 startPosition, required this.speed})
    : super(position: startPosition, size: Vector2(40, 40));

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.y += speed * dt;

    if (position.y > game.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Player) {
      game.gameOver();
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFFFF5555);
    canvas.drawOval(size.toRect(), paint);
  }
}
