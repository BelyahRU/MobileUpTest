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
    
    func setupCollectionView() {
        if segmentControl.selectedSegmentIndex == 0 {
            setupPhotosLayout()
        } else {
           setupVideosLayout()
        }
        contentCollectionView.backgroundColor = .clear
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.register(PhotoCollectionViewCell.self,
                                      forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseId)
        contentCollectionView.register(VideoCollectionViewCell.self,
                                      forCellWithReuseIdentifier: VideoCollectionViewCell.reuseId)
        contentCollectionView.setContentOffset(.zero, animated: false)
    }
    
    func setupPhotosLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let space = CGFloat(4)
        layout.minimumLineSpacing = space //между строками
        layout.minimumInteritemSpacing = space //между ячейками в строке
        let size = (view.frame.width - space)/2
        layout.itemSize = CGSize(width: size, height: size)
        contentCollectionView.collectionViewLayout = layout
    }
    
    func setupVideosLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let space = CGFloat(4)
        layout.minimumInteritemSpacing = space //между ячейками в строке
        layout.itemSize = CGSize(width: view.frame.width, height: 210)
        contentCollectionView.collectionViewLayout = layout
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0 {
            return photoViewModel.getCountPhotos()
        } else {
            return videosViewModel.videoCount
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if segmentControl.selectedSegmentIndex == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseId, for: indexPath) as? PhotoCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let photo = photoViewModel.getPhoto(by: indexPath.row)
            
            cell.setupCell(imageData: photo.imageData ?? Data())
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.reuseId, for: indexPath) as? VideoCollectionViewCell else {
                return UICollectionViewCell()
            }
            let video = videosViewModel.video(at: indexPath)
            cell.setupCell(video: video)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if segmentControl.selectedSegmentIndex == 0 {
            let photoData = photoViewModel.getPhoto(by: indexPath.row)
            let vc = PhotoViewController()
            vc.setupData(with: photoData)
            
            self.navigationController?.pushViewController(vc, animated: false)
            print("[LOGGER][MainViewController]: PhotoViewController is loaded")
        } else {
            let video = videosViewModel.video(at: indexPath)
            let vc = VideoViewController()
            vc.videoItem = video
            
            self.navigationController?.pushViewController(vc, animated: false)
            print("[LOGGER][MainViewController]: VideoViewController is loaded")
        }
    }
}
