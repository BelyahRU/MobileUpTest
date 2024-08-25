//
//  PhoroVC + Action.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation
import UIKit

//MARK: Action
extension PhotoViewController {
    public func setupButtons() {
        backButton = photoView.backButton
        shareButton = photoView.shareButton
        
        backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(sharePressed), for: .touchUpInside)
    }
    
    @objc
    func backPressed() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc
        func sharePressed() {
            guard let imageData = imageData else {
                print("[LOGGER][PhotoViewController]: Image data is nil")
                return
            }
            guard let image = UIImage(data: imageData) else {
                print("[LOGGER][PhotoViewController]: Image not found")
                return
            }
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            activityViewController.completionWithItemsHandler = { activity, success, items, error in
                if success, let activityType = activity {
                    if activityType == .saveToCameraRoll {
                        print("[LOGGER][PhotoViewController]: Photo saved to Camera Roll")
                    }
                }
            }

            self.present(activityViewController, animated: true, completion: nil)
        }

}
