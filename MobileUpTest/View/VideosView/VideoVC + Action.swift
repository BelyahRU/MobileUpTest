//
//  VideoVC + Action.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation
import UIKit

//MARK: - Action
extension VideoViewController {
    public func setupButtons() {
        shareButton = videoView.shareButton
        backButton = videoView.backButton
        
        shareButton.addTarget(self, action: #selector(sharePressed), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
    }
    
    @objc
    func sharePressed() {
        let saveToGalleryActivity = SaveImageToGalleryActivity()
        saveToGalleryActivity.configure(with: self)
        
        if let currentURL = webView.url {
            let activiTyViewController = UIActivityViewController(activityItems: [currentURL], applicationActivities:nil)
            
            if let popover = activiTyViewController.popoverPresentationController {
                popover.sourceView = self.view
            }
            
            self.present(activiTyViewController, animated: true)
        }
    }
    
    @objc
    func backPressed() {
        navigationController?.popViewController(animated: false)
    }
}
