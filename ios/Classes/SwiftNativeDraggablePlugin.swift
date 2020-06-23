import Flutter
import UIKit

@available(iOS 11.0, *)
public class SwiftNativeDraggablePlugin: NSObject, FlutterPlugin, UIDragInteractionDelegate, UIDropInteractionDelegate {    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "native_draggable", binaryMessenger: registrar.messenger())
    let instance = SwiftNativeDraggablePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  var image: UIImage?
  var previews: [String: UIView] = [:]
  public func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
      if (image == nil){
          return []
      }
      let provider = NSItemProvider(object: image!)
      let item = UIDragItem(itemProvider: provider)
      item.localObject = image
      return [item]
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "setDraggableFeedback":
        let appDelegate  = UIApplication.shared.delegate as! FlutterAppDelegate
        let viewController = appDelegate.window!.rootViewController as! FlutterViewController
        let args = call.arguments as! [String: Any]
        let key = args["key"] as! String
        print("setDraggableFeedback -> " + key)
        print("Previews: \(previews.count)")
        let width = args["width"] as! Double
        let height = args["height"] as! Double
        let dx = args["dx"] as! Double
        let dy = args["dy"] as! Double
        let bytes = args["bytes"] as! [Int]
        if (previews[key] != nil) {
            previews[key]?.removeFromSuperview()
        }
        var array: [UInt8] = []
        for item in bytes {
            array.append(UInt8(item))
        }
        let datos: Data = Data(array)
        image = UIImage(data: datos)!
        let testFrame = CGRect(x: dx, y: dy, width: width, height: height)
        let preview : UIView = UIView(frame: testFrame)
        preview.backgroundColor = UIColor(patternImage: image!)
        previews[key] = preview
        let dragInteraction = UIDragInteraction(delegate: self)
        preview.addInteraction(dragInteraction)
        viewController.view.addSubview(preview)
        result(true)
    case "updateDraggableFeedback":
        let args = call.arguments as! [String: Any]
        let key = args["key"] as! String
        let width = args["width"] as! Double
        let height = args["height"] as! Double
        let dx = args["dx"] as! Double
        let dy = args["dy"] as! Double
        let bytes = args["bytes"] as! [Int]
        var array: [UInt8] = []
        for item in bytes {
            array.append(UInt8(item))
        }
        let datos: Data = Data(array)
        image = UIImage(data: datos)!
        if (previews[key] != nil) {
            previews[key]?.frame =  CGRect(x: dx, y: dy, width: width, height: height)
            previews[key]?.backgroundColor = UIColor(patternImage: image!)
        }
        result(true)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
