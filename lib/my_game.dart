import 'package:flame/extensions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
// import 'package:flame_audio/bgm.dart';
// import 'package:flame_audio/flame_audio.dart';
import 'dart:ui' as ui;

class MyGame extends BaseGame {
  var direction = 'stop';
  SpriteComponent mia = SpriteComponent();
  SpriteComponent asuna = SpriteComponent();

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
  // Bgm audio = Bgm();
  bool musicIsPlaying = true;

  Future<void> onLoad() async {
    print('loading assets');
    // get game size with size.

    width = size[0];
    height = size[1];
    print('width: $width, height: $height');

    miaLeft = await loadSprite('mia_square_1.png');
    miaRight = await loadSprite('mia_square_right_1.png');

    Sprite asunaSprite = await loadSprite('asuna.gif');
    asuna
      ..sprite = asunaSprite
      ..size = Vector2(148, 180)
      ..anchor = Anchor.centerLeft
      ..x = -30
      ..y = height / 2;

    var background = SpriteComponent();

    background
      ..sprite = await loadSprite('bg-forest.png')
      ..size = Vector2(width, height);

    add(background);
    add(asuna);

    leftMiaSheet = await images.load('mia_left.png');
    final rightMiaSheet = await images.load('mia_right.png');
    final miaSpriteSize = Vector2(180, 180);
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
    // audio.initialize();
    // audio.play('audio/love_lost.mp3');
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (direction == 'right') {
      if (miaSpriteRight.x < width - miaSpriteRight.width / 2) {
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
      if (miaSpriteLeft.x - miaSpriteLeft.width / 2 < 100) {
        print('bounce');
        miaSpriteLeft.x = 300 + miaSpriteLeft.width / 2;
        // FlameAudio.play('bounce.wav');
      } else if (miaSpriteLeft.x > 0 + miaSpriteLeft.width / 2) {
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
