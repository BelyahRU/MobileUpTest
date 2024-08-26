//
//  PhotoViewController.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation
import UIKit

class PhotoViewController: UIViewController {
    
    //MARK: - Properties
    public let photoView = PhotoView()
    
    public var shareButton: UIButton!
    public var backButton: UIButton!
    
    public var imageData: Data?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Methods
    private func configure() {
        setupButtons()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(photoView)
        
        photoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension PhotoViewController {
    public func setupData(with photo: Photo) {
        self.imageData = photo.imageData
        photoView.setupData(imageData: photo.imageData ?? Data(), date: DateManager.getDate(from: photo.date))
    }
}
