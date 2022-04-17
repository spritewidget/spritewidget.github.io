import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:spritewidget_web/src/fireworks.dart';
import 'package:spritewidget_web/src/logo.dart';
import 'package:spritewidget_web/src/rockets.dart';

class SpriteDemo extends NodeWithSize {
  final ImageMap images;

  late Logo logo;
  late FireworksNode fireworks;
  late RocketsNode rockets;

  SpriteDemo({required this.images}) : super(const Size(1024.0, 1024.0)) {
    fireworks = FireworksNode(images: images, size: size);
    addChild(fireworks);

    rockets = RocketsNode(
        images: images, size: size, scaleRangeStart: 0.2, scaleRangeEnd: 1.0);
    addChild(rockets);

    logo = Logo(images: images);
    logo.position = _logoPosition;
    addChild(logo);
  }

  Offset get _logoPosition => Offset(size.width / 2, size.height / 3);

  @override
  void spriteBoxPerformedLayout() {
    fireworks.size = size;
    rockets.size = size;
    logo.position = _logoPosition;
  }
}
