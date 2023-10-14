import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent with HasGameRef {
  Player() : super(size: Vector2.all(50));

  @override
  FutureOr<void>? onLoad() {
    // _addPlayer();
    priority = 5;
    _loadAnimation();

    return super.onLoad();
  }

  @override
  void update(double dt) {
    _movePlayer(dt);
    super.update(dt);
  }

  /////////////////////// Helper ///////////////////////
  JoystickDirection direction = JoystickDirection.idle;

  final double playerSpeed = 200;
  final double _animationSpeed = 0.15;
  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _upAnimation;
  late final SpriteAnimation _downAnimation;
  late final SpriteAnimation _leftAnimation;
  late final SpriteAnimation _rightAnimation;

  FutureOr<void> _loadAnimation() async {
    final spriteSheet = SpriteSheet(
      image: gameRef.images.fromCache("player_spritesheet.png"),
      srcSize: Vector2(29, 32),
    );
    _idleAnimation = _addAnimation(spriteSheet, 0, to: 1);
    _upAnimation = _addAnimation(spriteSheet, 2);
    _downAnimation = _addAnimation(spriteSheet, 0);
    _leftAnimation = _addAnimation(spriteSheet, 1);
    _rightAnimation = _addAnimation(spriteSheet, 3);

    animation = _idleAnimation;
  }

  SpriteAnimation _addAnimation(SpriteSheet spriteSheet, int row, {int? to}) {
    return spriteSheet.createAnimation(
        row: row, stepTime: _animationSpeed, to: (to ?? 4));
  }

  // void _addPlayer() {
  //   // sprite = Sprite(gameRef.images.fromCache("player.png"));
  //   position = gameRef.size / 2;
  // }

  void _movePlayer(double delta) {
    switch (direction) {
      case JoystickDirection.up:
        move(delta: delta, y: -1);
        animation = _upAnimation;
        break;

      case JoystickDirection.down:
        move(delta: delta, y: 1);
        animation = _downAnimation;
        break;

      case JoystickDirection.left:
        move(delta: delta, x: -1);
        animation = _leftAnimation;
        break;

      case JoystickDirection.right:
        move(delta: delta, x: 1);
        animation = _rightAnimation;
        break;

      case JoystickDirection.upLeft:
        move(delta: delta, x: -1, y: -1);
        animation = _leftAnimation;
        break;

      case JoystickDirection.upRight:
        move(delta: delta, x: 1, y: -1);
        animation = _rightAnimation;
        break;

      case JoystickDirection.downLeft:
        move(delta: delta, x: -1, y: 1);
        animation = _leftAnimation;
        break;

      case JoystickDirection.downRight:
        move(delta: delta, x: 1, y: 1);
        animation = _rightAnimation;
        break;

      default:
        animation = _idleAnimation;
        break;
    }
  }

  void move({required double delta, double? x, double? y}) {
    position.add(Vector2(
        delta * playerSpeed * (x ?? 0), delta * playerSpeed * (y ?? 0)));
  }
}
