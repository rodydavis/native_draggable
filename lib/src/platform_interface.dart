import 'dart:ui';

import 'package:flutter/services.dart';

abstract class NativeDraggablePlatformInterface {
  MethodChannel _channel = MethodChannel('native_draggable');

  Future<bool?> setDraggableFeedback(
    String key, {
    Offset? offset = Offset.zero,
    Size? size = Size.zero,
    List<int>? image,
  }) =>
      _channel.invokeMethod<bool>('setDraggableFeedback', {
        'key': key,
        'dx': offset?.dx,
        'dy': offset?.dy,
        'width': size?.width,
        'height': size?.height,
        'bytes': image,
      });

  Future<bool?> updateDraggableFeedback(
    String key, {
    Offset? offset = Offset.zero,
    Size? size = Size.zero,
    List<int>? image,
  }) =>
      _channel.invokeMethod<bool>('updateDraggableFeedback', {
        'key': key,
        'dx': offset?.dx,
        'dy': offset?.dy,
        'width': size?.width,
        'height': size?.height,
        'bytes': image,
      });
}
