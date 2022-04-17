// Copyright 2019 The Viktor Lidholt. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:spritewidget_web/src/assets.dart';

const _avgTimeBetweenRockets = 0.2;

/// The fireworks node animates continuous fireworks.
class RocketsNode extends NodeWithSize {
  final ImageMap images;
  final double scaleRangeStart;
  final double scaleRangeEnd;

  RocketsNode({
    required this.images,
    required Size size,
    required this.scaleRangeStart,
    required this.scaleRangeEnd,
  }) : super(size);
  double _countDown = 0.0;

  @override
  void update(double dt) {
    // Called before rendering each frame, check if we should add any new
    // explosions.

    if (_countDown <= 0.0) {
      _addRocket();
      _countDown = randomDouble() * _avgTimeBetweenRockets * 2.0;
    }

    _countDown -= dt;
  }

  // Adds an explosion to the fireworks
  void _addRocket() {
    var rocketScale = _randomScaleFromRange();

    var startPosition = Offset(
      randomDouble() * size.width,
      size.height + 50 * rocketScale,
    );
    var endPosition = Offset(startPosition.dx, -250 * rocketScale);

    var rocket = _Rocket(images: images);
    rocket.scale = rocketScale;
    rocket.position = startPosition;

    motions.run(
      MotionSequence(
        motions: [
          MotionTween(
            setter: (Offset a) => rocket.position = a,
            start: startPosition,
            end: endPosition,
            duration: 2.0 / rocketScale,
          ),
          MotionRemoveNode(node: rocket),
        ],
      ),
    );

    addChild(rocket);
  }

  double _randomScaleFromRange() {
    return randomDouble() * (scaleRangeEnd - scaleRangeStart) + scaleRangeStart;
  }
}

class _Rocket extends Node {
  final ImageMap images;

  _Rocket({required this.images}) {
    var particles = ParticleSystem(
      texture: SpriteTexture(images[ImageAssets.fireParticle]!),
      life: 1.0,
      lifeVar: 0.3,
      posVar: Offset(10, 10),
      startSize: 0.4,
      startSizeVar: 0.25,
      endSize: 0.2,
      endSizeVar: 0.15,
      direction: 90,
      directionVar: 0,
      speed: 200,
      speedVar: 50.0,
      maxParticles: 150,
      emissionRate: 82.89703049584841,
      colorSequence: ColorSequence(
        colors: [
          Color(0x00FDE556),
          Color(0xFFFFEA4B),
          Color(0xFFDF3B3B),
          Color(0x00FF4141)
        ],
        stops: [0.0, 0.2, 0.7, 1.0],
      ),
      alphaVar: 0,
      redVar: 0,
      greenVar: 0,
      blueVar: 0,
      numParticlesToEmit: 0,
      autoRemoveOnFinish: false,
      blendMode: BlendMode.plus,
    )..position = Offset(0, 55);
    addChild(particles);

    var sprite = Sprite.fromImage(images[ImageAssets.rocket]!)..scale = 0.5;
    addChild(sprite);
  }
}
