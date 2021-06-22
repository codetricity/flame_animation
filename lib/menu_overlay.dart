import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'my_game.dart';

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
              game.audio.resume();
            },
            iconSize: 60.0,
          ),
          IconButton(
            icon: Icon(Icons.stop),
            color: Colors.blue,
            onPressed: () {
              game.direction = 'stop';
              game.audio.pause();
            },
            iconSize: 30.0,
          ),
          IconButton(
            icon: Icon(Icons.arrow_right_rounded),
            color: Colors.blue,
            onPressed: () {
              game.direction = 'right';
              game.audio.resume();
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
