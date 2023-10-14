import 'dart:async';

import 'package:flame/components.dart';

class Level extends SpriteComponent with HasGameRef {
  @override
  FutureOr<void>? onLoad() async {
    sprite = Sprite(gameRef.images.fromCache("rayworld_background.png"));
    size = sprite!.originalSize;
    return super.onLoad();
  }
}
