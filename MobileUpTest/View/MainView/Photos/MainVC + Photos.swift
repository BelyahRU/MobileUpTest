//
//  MainVC + Photos.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 25.08.2024.
//

import Foundation
import UIKit

//MARK: - Photos
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func setupPhotos() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let space = CGFloat(4)
        layout.minimumLineSpacing = space //между строками
        layout.minimumInteritemSpacing = space //между ячейками в строке
        let size = (view.frame.width - space)/2
        layout.itemSize = CGSize(width: size, height: size)
        photosCollectionView.collectionViewLayout = layout
        photosCollectionView.backgroundColor = .clear
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        photosCollectionView.register(PhotoCollectionViewCell.self,
                                      forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseId)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCountPhotos()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseId, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let photo = viewModel.getPhoto(by: indexPath.row)
        
        cell.setupCell(imageData: photo.imageData ?? Data())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoData = viewModel.getPhoto(by: indexPath.row)
        let vc = PhotoViewController()
        vc.setupData(with: photoData)
        
        self.navigationController?.pushViewController(vc, animated: false)
        print("[LOGGER][MainViewController]: PhotoViewController is loaded")
    }
}
