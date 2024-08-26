//
//  SaveImageToGalleryActivity.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation
import UIKit

class SaveImageToGalleryActivity: UIActivity {
    
    //MARK: - Properties
    private var selectedImage: UIImage?
    private weak var hostViewController: UIViewController?
    
    //MARK: - Override Properties
    override var activityTitle: String? {
        return "Сохранить в галерею"
    }
    
    override var activityImage: UIImage? {
        return UIImage(systemName: "arrow.down.to.line")
    }
    
    override var activityType: UIActivity.ActivityType? {
        return UIActivity.ActivityType("com.example.app.saveimage")
    }
    
    //MARK: - Override methods
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return activityItems.contains { $0 is UIImage }
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        for item in activityItems {
            if let image = item as? UIImage {
                self.selectedImage = image
            }
        }
    }
    
    override func perform() {
        if let imageToSave = selectedImage {
            UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(handleImageSaveCompletion(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        activityDidFinish(true)
    }
    
    @objc
    private func handleImageSaveCompletion(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        guard let viewController = hostViewController else { return }
        
        let alertTitle: String
        let alertMessage: String
        
        if let saveError = error {
            alertTitle = "Ошибка"
            alertMessage = "Не удалось сохранить изображение: \(saveError.localizedDescription)"
        } else {
            alertTitle = "Успешно"
            alertMessage = "Изображение было сохранено в галерею."
        }
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        viewController.present(alertController, animated: true)
    }

    
    func configure(with viewController: UIViewController) {
        self.hostViewController = viewController
    }
}
