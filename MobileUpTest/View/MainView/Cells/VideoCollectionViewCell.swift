//
//  VideoCollectionViewCell.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation
import UIKit
import SDWebImage
import SnapKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    public static let reuseId = "VideoCollectionViewCell"
    
    private let videoImageView: UIImageView = {
        let im = UIImageView()
        im.contentMode = .scaleAspectFill
        im.clipsToBounds = true
        return im
    }()
    
    private let titleVideoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.layer.cornerRadius = 14
        effectView.layer.masksToBounds = true
        return effectView
    }()
    
    //MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        videoImageView.image = nil
    }
    
    private func configure() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        contentView.addSubview(videoImageView)
        contentView.addSubview(blurView)
        blurView.contentView.addSubview(titleVideoLabel)
    }
    
    private func setupConstraints() {
        videoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        blurView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(150)
            make.height.greaterThanOrEqualTo(50) // Add a height constraint if needed
        }
        
        titleVideoLabel.snp.makeConstraints { make in
            make.leading.equalTo(blurView.snp.leading).offset(8)
            make.trailing.equalTo(blurView.snp.trailing).offset(-8)
            make.top.equalTo(blurView.snp.top).offset(8)
            make.bottom.equalTo(blurView.snp.bottom).offset(-8)
        }
    }
}

//MARK: - Settings for cell
extension VideoCollectionViewCell {
    public func setupCell(video: Video) {
        titleVideoLabel.text = video.titleVideo
        videoImageView.sd_setImage(with: URL(string: video.imagePreview[3].url))
    }
}
