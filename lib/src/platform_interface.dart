import 'package:flutter/services.dart';

abstract class NativeDraggablePlatformInterface {
  MethodChannel _channel = MethodChannel('native_draggable');

  Future<String> get platformVersion {
    return _channel.invokeMethod<String>('getPlatformVersion');
  }
}
