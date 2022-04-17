// Copyright 2019 The Viktor Lidholt. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:spritewidget_web/src/assets.dart';

const _avgTimeBetweenExplosions = 0.2;

/// The fireworks node animates continuous fireworks.
class FireworksNode extends NodeWithSize {
  final ImageMap images;

  FireworksNode({required this.images, required Size size}) : super(size);
  double _countDown = 0.0;

  @override
  void update(double dt) {
    // Called before rendering each frame, check if we should add any new
    // explosions.

    if (_countDown <= 0.0) {
      _addExplosion();
      _countDown = randomDouble() * _avgTimeBetweenExplosions * 2.0;
    }

    _countDown -= dt;
  }

  // Get a random color suitable for fireworks
  Color _randomExplosionColor() {
    double rand = randomDouble();
    if (rand < 0.25) {
      return Colors.deepPurple[400]!;
    } else if (rand < 0.5) {
      return Colors.yellow[400]!;
    } else if (rand < 0.75) {
      return Colors.amber[400]!;
    } else {
      return Colors.red[400]!;
    }
  }

  // Adds an explosion to the fireworks
  void _addExplosion() {
    Color startColor = _randomExplosionColor();
    Color endColor = startColor.withAlpha(0);

    // Use SpriteWidget's particle system to render the fireworks' explosions.
    ParticleSystem system = ParticleSystem(
      texture: SpriteTexture(images[ImageAssets.fireworkParticle]!),
      numParticlesToEmit: 100,
      emissionRate: 1000.0,
      rotateToMovement: true,
      startRotation: 90.0,
      endRotation: 90.0,
      speed: 100.0,
      speedVar: 50.0,
      startSize: 0.3,
      startSizeVar: 0.15,
      gravity: const Offset(0.0, 30.0),
      colorSequence: ColorSequence.fromStartAndEndColor(
        start: startColor,
        end: endColor,
      ),
    );

    // Place the explosion at a random position within the size bounds.
    system.position = Offset(
      randomDouble() * size.width,
      randomDouble() * size.height,
    );

    addChild(system);
  }
}
