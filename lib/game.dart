import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:run/components/player.dart';
import 'package:run/components/world.dart';

class RunningGame extends FlameGame {
  late final JoystickComponent joyStick;
  late final Player _player;
  late final Level _level;

  @override
  FutureOr<void>? onLoad() async {
    await images.loadAllImages();
    _player = Player();
    _level = Level();

    add(_player);
    add(_level);
    _addJoyStick();

    _player.position = _level.size / 2;

    camera.followComponent(
      _player,
      worldBounds: Rect.fromLTRB(0, 0, _level.size.x, _level.size.y),
    );

    return super.onLoad();
  }

  @override
  void update(double dt) {
    updateJobstick();

    super.update(dt);
  }

  _addJoyStick() {
    joyStick = JoystickComponent(
      priority: 10,
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache("HUD/Joystick.png"),
        ),
      ),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );

    add(joyStick);
  }

  void updateJobstick() {
    // switch (joyStick.direction) {
    //   case JoystickDirection.left ||
    //         JoystickDirection.upLeft ||
    //         JoystickDirection.downLeft:

    //     break;
    //   case JoystickDirection.right ||
    //         JoystickDirection.upRight ||
    //         JoystickDirection.downRight:
    //     break;
    //   default:
    //     break;
    // }
    _player.direction = joyStick.direction;
  }
}
