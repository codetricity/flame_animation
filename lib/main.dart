import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'menu_overlay.dart';
import 'my_game.dart';

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
