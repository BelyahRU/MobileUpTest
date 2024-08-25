//
//  PhotoView.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation
import UIKit

class PhotoView: UIView {
    
    //MARK: - Properties
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let photoImageView: UIImageView = {
        let im = UIImageView()
        im.contentMode = .scaleAspectFill
        im.clipsToBounds = true
        return im
    }()
    
    public let shareButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: Resources.Images.shareButton), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    public let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Resources.Images.backButton), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.1)
        return view
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
    private func configure() {
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupView() {
        backgroundColor = .white
    }
    
    private func setupSubviews() {
        addSubview(dateLabel)
        addSubview(shareButton)
        addSubview(photoImageView)
        addSubview(backButton)
        addSubview(lineView)
    }
    
    private func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(6)
            make.centerX.equalToSuperview()
        }
        
        shareButton.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(24)
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel.snp.centerY)
            make.leading.equalToSuperview().offset(10)
            make.size.equalTo(24)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(backButton.snp.bottom).offset(10)
        }
    }
}

//MARK: - Setuping data
extension PhotoView {
    public func setupData(imageData: Data, date: String) {
        photoImageView.image = UIImage(data: imageData)
        dateLabel.text = date
    }
}
