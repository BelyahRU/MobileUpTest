//
//  PhotoCollectionViewCell.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 25.08.2024.
//

import Foundation
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    public static let reuseId = "PhotoCollectionViewCell"
    
    private let photoImageView: UIImageView = {
        let im = UIImageView()
        im.contentMode = .scaleAspectFill
        im.clipsToBounds = true
        return im
    }()
    
    //MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    private func setupUI() {
        addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - Settings for cell
extension PhotoCollectionViewCell {
    public func setupCell(imageData: Data) {
        photoImageView.image = UIImage(data: imageData)
    }
}
