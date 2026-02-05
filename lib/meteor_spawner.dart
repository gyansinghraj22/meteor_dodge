import 'package:flame/components.dart';
import 'dart:math';
import 'meteor.dart';
import 'meteor_dodge_game.dart';

class MeteorSpawner extends Component with HasGameReference<MeteorDodgeGame> {
  late Timer _timer;
  final Random _random = Random();

  double spawnInterval = 1.5;
  double meteorSpeed = 300;

  @override
  void onLoad() {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(spawnInterval, repeat: true, onTick: spawnMeteor)..start();
  }

  void spawnMeteor() {
    final x = _random.nextDouble() * (game.size.x - 40);

    game.add(Meteor(startPosition: Vector2(x, -40), speed: meteorSpeed));
  }

  void increaseDifficulty() {
    meteorSpeed += 50;
    spawnInterval = (spawnInterval - 0.2).clamp(0.5, 2.0);

    _timer.stop();
    _startTimer();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
  }
}
