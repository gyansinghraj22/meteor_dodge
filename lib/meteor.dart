import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'meteor_dodge_game.dart';
import 'player.dart';
import 'bombardment_effect.dart';

class Meteor extends SpriteComponent
    with HasGameReference<MeteorDodgeGame>, CollisionCallbacks {
  double speed;

  Meteor({required Vector2 startPosition, required this.speed})
    : super(position: startPosition, size: Vector2(40, 40));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('bomb.png');
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
      // Create bombardment effect at collision point
      final effectPosition = Vector2(
        (position.x + other.position.x) / 2,
        (position.y + other.position.y) / 2,
      );

      final bombardment = BombardmentEffect(
        centerPosition: effectPosition,
        particleCount: 20,
        duration: 1.5,
      );

      game.add(bombardment);
      game.triggerBombardment(effectPosition);

      // Remove the meteor that caused the collision
      removeFromParent();

      // Trigger game over after a short delay to see the effect
      Future.delayed(Duration(milliseconds: 500), () {
        game.gameOver();
      });
    }
  }
}
