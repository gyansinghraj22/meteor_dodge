import 'package:flame/components.dart';

class MovingBackground extends Component {
  late SpriteComponent background1;
  late SpriteComponent background2;
  final double scrollSpeed;
  final Vector2 gameSize;

  MovingBackground({required this.gameSize, this.scrollSpeed = 50.0});

  @override
  Future<void> onLoad() async {
    // Create two background sprites for seamless scrolling
    background1 =
        SpriteComponent()
          ..sprite = await Sprite.load('background.jpg')
          ..size = gameSize
          ..position = Vector2(0, 0);

    background2 =
        SpriteComponent()
          ..sprite = await Sprite.load('background.jpg')
          ..size = gameSize
          ..position = Vector2(
            0,
            -gameSize.y,
          ); // Position second background above the first

    add(background1);
    add(background2);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Move both backgrounds downward
    background1.position.y += scrollSpeed * dt;
    background2.position.y += scrollSpeed * dt;

    // Reset background position when it goes off screen
    if (background1.position.y >= gameSize.y) {
      background1.position.y = background2.position.y - gameSize.y;
    }
    if (background2.position.y >= gameSize.y) {
      background2.position.y = background1.position.y - gameSize.y;
    }
  }
}
