//
//  VideoView.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation
import UIKit

class VideoView: UIView {
    
    //MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
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
    
    public let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.1)
        return view
    }()
    
    public var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.color = .gray
        ai.hidesWhenStopped = true
        ai.isHidden = false
        return ai
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
        addSubview(titleLabel)
        addSubview(shareButton)
        addSubview(backButton)
        addSubview(lineView)
        addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(6)
            make.centerX.equalToSuperview()
            make.width.equalTo(220)
        }
        
        shareButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(24)
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.leading.equalToSuperview().offset(10)
            make.size.equalTo(24)
        }
        
        lineView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(backButton.snp.bottom).offset(10)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.center.equalToSuperview()
        }
    }
}

//MARK: - Setuping data
extension VideoView {
    public func setupData(title: String) {
        titleLabel.text = title
    }
}
