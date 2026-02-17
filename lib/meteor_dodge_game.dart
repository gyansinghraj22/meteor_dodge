import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'player.dart';
import 'meteor_spawner.dart';
import 'moving_background.dart';
import 'pause_button.dart';

class MeteorDodgeGame extends FlameGame with HasCollisionDetection {
  late Player player;
  late MeteorSpawner spawner;
  late TextComponent scoreText;
  late PauseButton pauseButton;
  late MovingBackground movingBackground;

  double scoreAccumulator = 0.0;
  int score = 0;
  double difficultyTimer = 0;

  // Game states
  bool gameStarted = false;
  bool gamePaused = false;

  @override
  Future<void> onLoad() async {
    // Show start menu initially
    overlays.add('StartMenu');
    pauseEngine();
  }

  void resetGame() {
    // Clear all game components
    removeAll(children.toList());
    overlays.remove('GameOver');

    score = 0;
    scoreAccumulator = 0.0;
    difficultyTimer = 0;

    // Add moving background first so it renders behind everything else
    movingBackground = MovingBackground(gameSize: size, scrollSpeed: 100.0);
    add(movingBackground);

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

    // Add pause button
    pauseButton = PauseButton(position: Vector2(size.x - 60, 50));
    add(pauseButton);

    resumeEngine();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Only update score and difficulty when game is started and not paused
    if (!gameStarted || gamePaused) return;

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
    gameStarted = false;
    gamePaused = false;
    pauseEngine();
    overlays.add('GameOver');
  }

  void startGame() {
    overlays.remove('StartMenu');
    gameStarted = true;
    gamePaused = false;
    resetGame();
  }

  void pauseGame() {
    if (gameStarted && !gamePaused) {
      gamePaused = true;
      pauseEngine();
      overlays.add('PauseMenu');
    }
  }

  void resumeGame() {
    if (gameStarted && gamePaused) {
      gamePaused = false;
      overlays.remove('PauseMenu');
      resumeEngine();
    }
  }

  void restartGame() {
    overlays.remove('PauseMenu');
    overlays.remove('GameOver');
    gameStarted = true;
    gamePaused = false;
    resetGame();
  }

  void triggerBombardment(Vector2 position) {
    // Create a simple visual feedback for bombardment
    // You can expand this to add more effects like sound, particles, etc.
  }
}
