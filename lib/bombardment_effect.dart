import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class BombardmentEffect extends Component {
  final Vector2 centerPosition;
  final int particleCount;
  final double duration;

  BombardmentEffect({
    required this.centerPosition,
    this.particleCount = 15,
    this.duration = 1.0,
  });

  @override
  Future<void> onLoad() async {
    // Create multiple explosion particles
    for (int i = 0; i < particleCount; i++) {
      final particle = ExplosionParticle(
        startPosition: centerPosition.clone(),
        angle: (i * 2 * pi) / particleCount,
        speed: 100 + Random().nextDouble() * 100,
        lifetime: duration,
      );
      add(particle);
    }

    // Remove this effect after the duration
    add(RemoveEffect(delay: duration + 0.5));
  }
}

class ExplosionParticle extends CircleComponent {
  final Vector2 startPosition;
  final double angle;
  final double speed;
  final double lifetime;
  double age = 0;

  ExplosionParticle({
    required this.startPosition,
    required this.angle,
    required this.speed,
    required this.lifetime,
  }) : super(
         radius: 3,
         paint: Paint()..color = Colors.orange,
         position: startPosition,
       );

  @override
  void update(double dt) {
    super.update(dt);

    age += dt;

    // Move particle outward
    final velocity = Vector2(cos(angle), sin(angle)) * speed;
    position.add(velocity * dt);

    // Fade out over time
    final alpha = (1.0 - (age / lifetime)).clamp(0.0, 1.0);
    paint.color = Colors.orange.withOpacity(alpha);

    // Change color from orange to red over time
    final colorProgress = age / lifetime;
    if (colorProgress < 0.5) {
      paint.color = Color.lerp(
        Colors.yellow,
        Colors.orange,
        colorProgress * 2,
      )!.withOpacity(alpha);
    } else {
      paint.color = Color.lerp(
        Colors.orange,
        Colors.red,
        (colorProgress - 0.5) * 2,
      )!.withOpacity(alpha);
    }

    // Shrink particle over time
    radius = 3 * (1.0 - colorProgress);

    // Remove when lifetime is over
    if (age >= lifetime) {
      removeFromParent();
    }
  }
}
