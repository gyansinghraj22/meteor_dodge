import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'player.dart';
import 'meteor_spawner.dart';

class MeteorDodgeGame extends FlameGame with HasCollisionDetection {
  late Player player;
  late MeteorSpawner spawner;
  late TextComponent scoreText;

  double scoreAccumulator = 0.0;
  int score = 0;
  double difficultyTimer = 0;

  @override
  Future<void> onLoad() async {
    resetGame();
  }

  void resetGame() {
    // Clear all game components
    removeAll(children.toList());
    overlays.remove('GameOver');

    score = 0;
    scoreAccumulator = 0.0;
    difficultyTimer = 0;

    player = Player(size);
    spawner = MeteorSpawner();

    // Add components directly to the game
    add(player);
    add(spawner);

    // Add score text with better positioning and visibility
    scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(20, 50),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(offset: Offset(2, 2), blurRadius: 4.0, color: Colors.black),
          ],
        ),
      ),
    );
    add(scoreText);
    resumeEngine();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Accumulate score over time
    scoreAccumulator += dt * 10; // 10 points per second
    int newScore = scoreAccumulator.toInt();

    if (newScore != score) {
      score = newScore;
      scoreText.text = 'Score: $score';
      print('Score updated to: $score');
    }

    difficultyTimer += dt;

    if (difficultyTimer > 10) {
      spawner.increaseDifficulty();
      difficultyTimer = 0;
      print('Difficulty increased!');
    }
  }

  void gameOver() {
    pauseEngine();
    overlays.add('GameOver');
  }
}
