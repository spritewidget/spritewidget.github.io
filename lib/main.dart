import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:spritewidget_web/src/assets.dart';
import 'package:spritewidget_web/src/demo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const SpriteWidgetApp());
}

class SpriteWidgetApp extends StatelessWidget {
  const SpriteWidgetApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpriteWidget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.compact,
      ),
      home: const SpriteWidgetHomePage(),
    );
  }
}

class SpriteWidgetHomePage extends StatefulWidget {
  const SpriteWidgetHomePage({Key? key}) : super(key: key);

  @override
  State<SpriteWidgetHomePage> createState() => _SpriteWidgetHomePageState();
}

class _SpriteWidgetHomePageState extends State<SpriteWidgetHomePage> {
  NodeWithSize? rootNode;

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    var images = ImageMap();
    await images.load(ImageAssets.all);
    setState(() {
      rootNode = SpriteDemo(images: images);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (rootNode == null) {
      return Scaffold(
        body: _GradientContainer(
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.lightBlue[200],
              strokeWidth: 8,
            ),
          ),
        ),
      );
    }

    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: _GradientContainer(
        child: Stack(
          children: [
            SpriteWidget(
              rootNode!,
              transformMode: SpriteBoxTransformMode.fixedWidth,
            ),
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: Colors.cyan[600],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 46, vertical: 16),
                    elevation: 16,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                    onPressed: () {
                      launch('https://github.com/spritewidget/spritewidget');
                    },
                    child: const Text(
                      'Get Started :)',
                      style: TextStyle(
                        fontFamily: 'Shadows',
                        fontSize: 40,
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                            blurRadius: 2,
                            offset: Offset(0.0, 2.0),
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  MaterialButton(
                    color: Colors.cyan[600],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 46, vertical: 16),
                    elevation: 16,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                    onPressed: () {
                      launch('https://spritewidget.com/spaceblast');
                    },
                    child: const Text(
                      'Play a Game',
                      style: TextStyle(
                        fontFamily: 'Shadows',
                        fontSize: 20,
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                            blurRadius: 2,
                            offset: Offset(0.0, 2.0),
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: max(mq.size.height / 4 - 90, 0),
                  ),
                  Image.asset(
                    'assets/serverpod-logo.png',
                    width: 130,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'By Serverpod – The missing backend for Flutter.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _GradientContainer extends StatelessWidget {
  const _GradientContainer({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(12, 68, 155, 1.0),
            Color.fromRGBO(6, 34, 77, 1.0),
          ],
        ),
      ),
      child: child,
    );
  }
}
