import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'meteor_dodge_game.dart';
import 'game_over_overlay.dart';

void main() {
  runApp(
    GameWidget(
      game: MeteorDodgeGame(),
      overlayBuilderMap: {
        'GameOver': (context, game) =>
            GameOverOverlay(game: game as MeteorDodgeGame),
      },
    ),
  );
}
