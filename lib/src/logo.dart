import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:spritewidget_web/src/assets.dart';

class Logo extends Node {
  final ImageMap images;
  late final Sprite logo;

  Logo({required this.images}) {
    // Logo
    logo = Sprite.fromImage(images[ImageAssets.logo]!);
    logo.scale = 0.35;
    logo.opacity = 0.0;
    addChild(logo);

    // Logo intro animation.

    final logoIntroMotion = MotionGroup(motions: [
      MotionTween(
        setter: (double a) => logo.opacity = a,
        start: 0.0,
        end: 1.0,
        duration: 0.5,
      ),
      MotionTween(
        setter: (double a) => logo.scale = a,
        start: 0.0,
        end: 0.45,
        duration: 1.0,
        curve: Curves.bounceOut,
      ),
    ]);

    logo.motions.run(
      MotionSequence(
        motions: [
          MotionDelay(delay: 0.5),
          logoIntroMotion,
        ],
      ),
    );

    // Pulsating animation
    var logoPulsating = MotionSequence(motions: [
      MotionDelay(delay: 3.0),
      MotionTween(
        setter: (double a) => logo.scale = a,
        start: 0.45,
        end: 0.55,
        duration: 1.0,
        curve: Curves.bounceOut,
      ),
      MotionTween(
        setter: (double a) => logo.scale = a,
        start: 0.55,
        end: 0.45,
        duration: 1.0,
        curve: Curves.bounceOut,
      ),
    ]);
    logo.motions.run(MotionRepeatForever(motion: logoPulsating));

    // Label
    var label = Label(
      '2D Game Engine for Flutter',
      textStyle: _styleWithOpacity(0.0),
    );
    label.position = const Offset(0.0, 70.0);
    label.skewX = -3.5;
    label.textAlign = TextAlign.center;
    label.scale = 1.0;
    addChild(label);

    // Label intro animation
    final labelIntroMotion = MotionGroup(motions: [
      MotionTween(
        setter: (double a) => label.textStyle = _styleWithOpacity(a),
        start: 0.0,
        end: 1.0,
        duration: 0.5,
      ),
      MotionTween(
        setter: (double a) => label.scale = a,
        start: 0.7,
        end: 1.0,
        duration: 1.0,
        curve: Curves.elasticOut,
      ),
    ]);

    label.motions.run(
      MotionSequence(
        motions: [
          MotionDelay(delay: 1.0),
          labelIntroMotion,
        ],
      ),
    );
  }

  TextStyle _styleWithOpacity(double opacity) {
    return TextStyle(
      fontFamily: 'Shadows',
      fontWeight: FontWeight.w400,
      fontSize: 32,
      color: Colors.white.withOpacity(opacity),
      shadows: [
        BoxShadow(
          blurRadius: 4,
          offset: const Offset(0.0, 2.0),
          color: Colors.black.withOpacity(opacity * 0.7),
        ),
      ],
    );
  }
}
