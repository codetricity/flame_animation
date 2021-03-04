import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/services.dart';

void main() {
  var game = MyGame();
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            GameWidget(game: game),
            MenuOverlay(game: game),
          ],
        ),
      ),
    ),
  );
}

class MenuOverlay extends StatelessWidget {
  const MenuOverlay({
    Key key,
    @required this.game,
  }) : super(key: key);

  final MyGame game;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TextButton(
          //   onPressed: () {
          //     game.direction = 'left';
          //   },
          //   child: Text('left'),
          // ),
          IconButton(
            icon: Icon(Icons.arrow_left_rounded),
            color: Colors.blue,
            onPressed: () {
              game.direction = 'left';
            },
            iconSize: 60.0,
          ),
          IconButton(
            icon: Icon(Icons.stop),
            color: Colors.blue,
            onPressed: () {
              game.direction = 'stop';
            },
            iconSize: 30.0,
          ),
          IconButton(
            icon: Icon(Icons.arrow_right_rounded),
            color: Colors.blue,
            onPressed: () {
              game.direction = 'right';
            },
            iconSize: 60.0,
          ),
          // TextButton(
          //   onPressed: () {
          //     game.direction = 'right';
          //   },
          //   child: Text('right'),
          // ),
        ],
      ),
    );
  }
}

class MyGame extends BaseGame {
  var direction = 'stop';
  SpriteComponent mia = SpriteComponent();
  SpriteAnimationComponent miaSpriteLeft = SpriteAnimationComponent();
  SpriteAnimationComponent miaSpriteRight = SpriteAnimationComponent();
  Sprite miaLeft;
  Sprite miaRight;
  ui.Image leftMiaSheet;
  bool rightUpdated = false;
  bool leftUpdated = true;
  double width;
  double height;
  double speed = 2.0;

  Future<void> onLoad() async {
    print('loading assets');
    // get game size with size.

    print('width: $width, height: $height');
    width = size[0];
    height = size[1];

    miaLeft = await loadSprite('mia_square_1.png');
    miaRight = await loadSprite('mia_square_right_1.png');

    mia
      ..sprite = miaLeft
      ..size = Vector2(200, 200)
      ..anchor = Anchor.center
      ..x = width / 2
      ..y = height / 2;
    // add(mia);

    leftMiaSheet = await images.load('mia_left.png');
    final rightMiaSheet = await images.load('mia_right.png');
    final miaSpriteSize = Vector2(200, 200);
    SpriteAnimationData miaSpriteData = SpriteAnimationData.sequenced(
        amount: 4, stepTime: 0.12, textureSize: Vector2(300.0, 300.0));
    miaSpriteLeft =
        SpriteAnimationComponent.fromFrameData(leftMiaSheet, miaSpriteData)
          ..size = miaSpriteSize
          ..anchor = Anchor.center
          ..x = width / 2
          ..y = height / 2;
    add(miaSpriteLeft);

    miaSpriteRight =
        SpriteAnimationComponent.fromFrameData(rightMiaSheet, miaSpriteData)
          ..size = miaSpriteSize
          ..anchor = Anchor.center
          ..x = width / 2
          ..y = height / 2;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (direction == 'right') {
      if (miaSpriteRight.x < width) {
        miaSpriteRight.x += speed;
      }

      if (!rightUpdated) {
        miaSpriteLeft.position = miaSpriteRight.position;
        remove(miaSpriteLeft);
        add(miaSpriteRight);
        this.rightUpdated = true;
        this.leftUpdated = false;
      }
    } else if (direction == 'left') {
      if (miaSpriteLeft.x > 0) {
        miaSpriteLeft.x -= speed;
      }

      if (!leftUpdated) {
        miaSpriteRight.position = miaSpriteLeft.position;
        remove(miaSpriteRight);
        add(miaSpriteLeft);
        this.leftUpdated = true;
        this.rightUpdated = false;
      }
    }
    // print(direction);
  }
}
