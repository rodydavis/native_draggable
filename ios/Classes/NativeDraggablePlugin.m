#import "NativeDraggablePlugin.h"
#if __has_include(<native_draggable/native_draggable-Swift.h>)
#import <native_draggable/native_draggable-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "native_draggable-Swift.h"
#endif

@implementation NativeDraggablePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeDraggablePlugin registerWithRegistrar:registrar];
}
@end
