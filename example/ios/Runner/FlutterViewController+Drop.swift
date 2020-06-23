//
//  FlutterViewController+Drop.swift
//  Runner
//
//  Created by Rody Davis on 6/22/20.
//

import UIKit
import Foundation
import MobileCoreServices

extension FLutterViewController: UIDropInteractionDelegate {
    // MARK: - UIDropInteractionDelegate
    
    /**
         Ensure that the drop session contains a drag item with a data representation
         that the view can consume.
    */
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.hasItemsConforming(toTypeIdentifiers: [kUTTypeImage as String]) && session.items.count == 1
    }
    
    // Update UI, as needed, when touch point of drag session enters view.
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnter session: UIDropSession) {
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)
    }
    
    /**
         Required delegate method: return a drop proposal, indicating how the
         view is to handle the dropped items.
    */
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)

        let operation: UIDropOperation

        if imageView.frame.contains(dropLocation) {
            /*
                 If you add in-app drag-and-drop support for the .move operation,
                 you must write code to coordinate between the drag interaction
                 delegate and the drop interaction delegate.
            */
            operation = session.localDragSession == nil ? .copy : .move
        } else {
            // Do not allow dropping outside of the image view.
            operation = .cancel
        }

        return UIDropProposal(operation: operation)
    }
    
    /**
         This delegate method is the only opportunity for accessing and loading
         the data representations offered in the drag item.
    */
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        // Consume drag items (in this example, of type UIImage).
        session.loadObjects(ofClass: UIImage.self) { imageItems in
            let images = imageItems as! [UIImage]

            /*
                 If you do not employ the loadObjects(ofClass:completion:) convenience
                 method of the UIDropSession class, which automatically employs
                 the main thread, explicitly dispatch UI work to the main thread.
                 For example, you can use `DispatchQueue.main.async` method.
            */
            self.imageView.image = images.first
        }

        // Perform additional UI updates as needed.
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)
    }
    
    // Update UI, as needed, when touch point of drag session leaves view.
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidExit session: UIDropSession) {
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)
    }
    
    // Update UI and model, as needed, when drop session ends.
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnd session: UIDropSession) {
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)
    }

    // MARK: - Helpers

    func updateLayers(forDropLocation dropLocation: CGPoint) {
        if imageView.frame.contains(dropLocation) {
            view.layer.borderWidth = 0.0
            imageView.layer.borderWidth = 2.0
        } else if view.frame.contains(dropLocation) {
            view.layer.borderWidth = 5.0
            imageView.layer.borderWidth = 0.0
        } else {
            view.layer.borderWidth = 0.0
            imageView.layer.borderWidth = 0.0
        }
    }
}
