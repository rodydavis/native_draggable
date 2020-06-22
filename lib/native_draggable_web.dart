import 'dart:html' as html;

import 'src/platform_interface.dart';

class NativeDraggable extends NativeDraggablePlatformInterface {
  NativeDraggable._();
  static NativeDraggable instance = NativeDraggable._();

  @override
  Future<String> get platformVersion {
    return super.platformVersion;
  }
}
