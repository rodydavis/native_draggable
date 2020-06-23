import Cocoa
import FlutterMacOS

public class NativeDraggablePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "native_draggable", binaryMessenger: registrar.messenger)
    let instance = NativeDraggablePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "setDraggableFeedback":
        let args = call.arguments as! [String: Any]
        let width = args["width"] as! Double
        let height = args["height"] as! Double
        let dx = args["dx"] as! Double
        let dy = args["dy"] as! Double
        let bytes = args["bytes"] as! [Int]
        print("Size: [\(width)x\(height)]")
        print("Offset: (\(dx),\(dy))")
        print("Bytes: \(bytes)")
        result(true)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
