//
//  MainViewController.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 25.08.2024.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
       //MARK: Properties
       weak var coordinator: MainCoordinator?

       //MARK: UI
       public var mainView = MainView()
       public var signOutButton: UIButton!
       public var segmentControl: UISegmentedControl!
       public var contentCollectionView: UICollectionView!
       public var videosCollectionView: UICollectionView!
       public var loadingIndicator: UIActivityIndicatorView!
       
       //MARK: ViewModel
       public var photoViewModel = PhotosViewModel()
       public var videosViewModel = VideoViewModel()
       
       //MARK: Life cycle
       override func viewDidLoad() {
           super.viewDidLoad()
           configure()
       }
       
       //MARK: Methods
       private func configure() {
           setupViews()
           setupUI()
           setupActions()
           fetchContent()  // Загрузка фото и видео одновременно
       }
       
       private func setupViews() {
           loadingIndicator = mainView.loadingIndicatior
           signOutButton = mainView.signOutButton
           segmentControl = mainView.photoVideoSegmentPicker
           contentCollectionView = mainView.photosCollectionView
           videosCollectionView = mainView.videosCollectionView
       }
       
       private func setupUI() {
           view.addSubview(mainView)
           mainView.snp.makeConstraints { make in
               make.edges.equalToSuperview()
           }
       }

       private func fetchContent() {
           showLoadingIndicator()
           
           let dispatchGroup = DispatchGroup()
           
           // Загрузка фото
           dispatchGroup.enter()
           fetchPhotos {
               dispatchGroup.leave()
           }
           
           // Загрузка видео
           dispatchGroup.enter()
           fetchVideos {
               dispatchGroup.leave()
           }
           
           // Когда обе загрузки завершены
           dispatchGroup.notify(queue: .main) {
               self.hideLoadingIndicator()
               self.contentCollectionView.reloadData()
               self.videosCollectionView.reloadData()
           }
       }
       
       func fetchPhotos(completion: @escaping () -> Void) {
           photoViewModel.fetchPhotos { [weak self] success in
               DispatchQueue.main.async {
                   if success {
                       self?.setupCollectionView()
                   } else {
                       let error = self?.photoViewModel.getError()
                       self?.coordinator?.showErrorLoadingPhotosMessage(error: error ?? "Unknown error")
                   }
                   completion()
               }
           }
       }
       
       func fetchVideos(completion: @escaping () -> Void) {
           videosViewModel.loadVideos { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success:
                       print("OK")
                   case .failure(let error):
                       self?.coordinator?.showErrorLoadingPhotosMessage(error: error.localizedDescription)
                   }
                   completion()
               }
           }
       }
       
       private func showLoadingIndicator() {
           DispatchQueue.main.async {
               self.loadingIndicator.isHidden = false
               self.loadingIndicator.startAnimating()
           }
       }
       
       private func hideLoadingIndicator() {
           DispatchQueue.main.async {
               self.loadingIndicator.isHidden = true
               self.loadingIndicator.stopAnimating()
           }
       }

}
