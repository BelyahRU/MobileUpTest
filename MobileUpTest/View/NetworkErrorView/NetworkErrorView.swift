//
//  NoInternetView.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 23.08.2024.
//

import Foundation
import UIKit

//MARK: - NetworkErrorViewDelegate
protocol NetworkErrorViewDelegate: AnyObject {
    func didTapLoginAgainButton()
}

class NetworkErrorView: UIView {
    
    //MARK: - Properties
    weak var delegate: NetworkErrorViewDelegate?
    
    private let noSignalImageView: UIImageView = {
        let image  = UIImageView()
        image.image = UIImage(systemName: "antenna.radiowaves.left.and.right.slash")
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет интернет соеденения. Повторите попытку познее"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    public let loginAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Повторить вход", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .black
        return button
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
        setupUI()
        setupSubviews()
        setupConstraints()
        setupButton() // in extension
    }
    
    private func setupUI() {
        backgroundColor = .white
    }
    
    private func setupSubviews() {
        addSubview(noSignalImageView)
        addSubview(textLabel)
        addSubview(loginAgainButton)
    }
    
    
    private func setupConstraints() {
        
        noSignalImageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(200)
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.top.equalTo(noSignalImageView.snp.bottom).offset(40)
            make.height.equalTo(44)
        }
        
        loginAgainButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(textLabel.snp.bottom).offset(40)
            make.height.equalTo(44)
        }
    }
    
}
