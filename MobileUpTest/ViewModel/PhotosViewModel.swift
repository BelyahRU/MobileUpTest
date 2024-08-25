//
//  PhotosViewModel.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 25.08.2024.
//

import Foundation

class PhotosViewModel {
    
    private(set) var error: Error?
    private(set) var photos: [Photo] = []
    
    func fetchPhotos(completion: @escaping (Bool) -> Void) {
        PhotosCaller.shared.getAllPhotos { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self?.photos = photos
                    completion(true)
                case .failure(let error):
                    self?.error = error
                    print("Error: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
    }
    
    func getError() -> String {
        if let error = error {
            return error.localizedDescription
        } else {
            return "unknown error"
        }
    }
    
    func getCountPhotos() -> Int {
        photos.count
    }
    
    func getPhoto(by id: Int) -> Photo {
        return photos[id]
    }
}

