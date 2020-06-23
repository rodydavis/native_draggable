import 'src/platform_interface.dart';

export 'src/custom_draggable.dart';

class NativeDraggablePlugin extends NativeDraggablePlatformInterface {
  NativeDraggablePlugin._();
  static NativeDraggablePlugin instance = NativeDraggablePlugin._();
}
