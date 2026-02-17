import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'meteor_dodge_game.dart';

class PauseButton extends TextComponent
    with TapCallbacks, HasGameReference<MeteorDodgeGame> {
  PauseButton({required Vector2 position})
    : super(
        text: '⏸️',
        position: position,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 32,
            shadows: [
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 4.0,
                color: Colors.black,
              ),
            ],
          ),
        ),
      );

  @override
  bool onTapDown(TapDownEvent event) {
    game.pauseGame();
    return true;
  }
}
