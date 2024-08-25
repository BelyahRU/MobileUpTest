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
    
    //MARK: ViewModel
    public var viewModel = PhotosViewModel()
    
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
    }
    
    private func setupViews() {
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
}
