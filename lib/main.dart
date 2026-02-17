import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'meteor_dodge_game.dart';
import 'game_over_overlay.dart';
import 'start_menu_overlay.dart';
import 'pause_menu_overlay.dart';

void main() {
  runApp(
    GameWidget(
      game: MeteorDodgeGame(),
      overlayBuilderMap: {
        'GameOver':
            (context, game) => GameOverOverlay(game: game as MeteorDodgeGame),
        'StartMenu':
            (context, game) => StartMenuOverlay(game: game as MeteorDodgeGame),
        'PauseMenu':
            (context, game) => PauseMenuOverlay(game: game as MeteorDodgeGame),
      },
    ),
  );
}
