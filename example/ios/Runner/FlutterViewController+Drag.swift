//
//  FlutterViewController+Drag.swift
//  Runner
//
//  Created by Rody Davis on 6/22/20.
//

import UIKit

extension FlutterViewController: UIDragInteractionDelegate {
    // MARK: - UIDragInteractionDelegate
    
    /*
         The `dragInteraction(_:itemsForBeginning:)` method is the essential method
         to implement for allowing dragging from a view.
    */
    public func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let image = imageView.image else { return [] }

        let provider = NSItemProvider(object: image)
        let item = UIDragItem(itemProvider: provider)
        item.localObject = image
        
        /*
             Returning a non-empty array, as shown here, enables dragging. You
             can disable dragging by instead returning an empty array.
        */
        return [item]
    }

    /*
         Code below here adds visual enhancements but is not required for minimal
         dragging support. If you do not implement this method, the system uses
         the default lift animation.
    */
    public func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
        guard let image = item.localObject as? UIImage else { return nil }
        
        // Scale the preview image view frame to the image's size.
        let frame: CGRect
        if image.size.width > image.size.height {
            let multiplier = imageView.frame.width / image.size.width
            frame = CGRect(x: 0, y: 0, width: imageView.frame.width, height: image.size.height * multiplier)
        } else {
            let multiplier = imageView.frame.height / image.size.height
            frame = CGRect(x: 0, y: 0, width: image.size.width * multiplier, height: imageView.frame.height)
        }

        // Create a new view to display the image as a drag preview.
        let previewImageView = UIImageView(image: image)
        previewImageView.contentMode = .scaleAspectFit
        previewImageView.frame = frame

        /*
             Provide a custom targeted drag preview that lifts from the center
             of imageView. The center is calculated because it needs to be in
             the coordinate system of imageView. Using imageView.center returns
             a point that is in the coordinate system of imageView's superview,
             which is not what is needed here.
         */
        let center = CGPoint(x: imageView.bounds.midX, y: imageView.bounds.midY)
        let target = UIDragPreviewTarget(container: imageView, center: center)
        return UITargetedDragPreview(view: previewImageView, parameters: UIDragPreviewParameters(), target: target)
    }
}
