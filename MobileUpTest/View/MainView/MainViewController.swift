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
    public var signOutButton: UIButton! // sign out
    public var segmentControl: UISegmentedControl! // photos/videos button
    public var photosCollectionView: UICollectionView! // photos
    public var videosCollectionView: UICollectionView! // videos
    public var loadingIndicator: UIActivityIndicatorView!
    
    //MARK: ViewModel
    public var viewModel = PhotosViewModel()
    public var photos = [Data]()
    
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
        fetchPhotos()
//        setupPhotos()
    }
    
    private func setupViews() {
        loadingIndicator = mainView.loadingIndicatior
        signOutButton = mainView.signOutButton
        segmentControl = mainView.photoVideoSegmentPicker
        photosCollectionView = mainView.photosCollectionView
        videosCollectionView = mainView.videosCollectionView
    }
    
    private func setupUI() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func fetchPhotos() {
        showLoadingIndicator()
            viewModel.fetchPhotos { [weak self] success in
                self?.hideLoadingIndicator()
                print(success)
                if success {
                    self?.setupPhotos()
                    self?.photosCollectionView.reloadData()
                } else {
                    let error = self?.viewModel.getError()
                    self?.coordinator?.showErrorLoadingPhotosMessage(error: error ?? "Unknown error")
                }
            }
    }
    
    private func showLoadingIndicator() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
    }

}
