import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/extensions.dart';

void main() {
  var game = MyGame();
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            GameWidget(game: game),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      game.direction = 'left';
                    },
                    child: Text('left'),
                  ),
                  TextButton(
                    onPressed: () {
                      game.direction = 'right';
                    },
                    child: Text('right'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class MyGame extends BaseGame {
  var direction = 'stop';
  SpriteComponent mia = SpriteComponent();
  Sprite miaLeft;
  Sprite miaRight;

  Future<void> onLoad() async {
    print('loading assets');
    var width = MediaQueryData.fromWindow(window).size.width;
    var height = MediaQueryData.fromWindow(window).size.height;

    print('width: $width');
    print('height: $height');
    miaLeft = await loadSprite('mia_square_1.png');
    miaRight = await loadSprite('mia_square_right_1.png');

    mia
      ..sprite = miaLeft
      ..size = Vector2(200, 200)
      ..anchor = Anchor.center
      ..x = width / 2
      ..y = height / 2;
    add(mia);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (direction == 'right') {
      if (mia.sprite == miaLeft) {
        mia.sprite = miaRight;
      }
    } else if (direction == 'left') {
      if (mia.sprite == miaRight) {
        mia.sprite = miaLeft;
      }
    }
    // print(direction);
  }
}
