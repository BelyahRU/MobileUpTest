//
//  AuthView.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 23.08.2024.
//

import Foundation
import UIKit
import SnapKit

class AuthView: UIView {
    
    //MARK: - Properties
    private let headerLabel: UILabel = {
       let label = UILabel()
        label.text = "Mobile Up\nGallery"
        label.font = UIFont.systemFont(ofSize: 44, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    public let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вход через VK", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
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
    }
    
    private func setupUI() {
        backgroundColor = .white
    }
    
    private func setupSubviews() {
        addSubview(headerLabel)
        addSubview(loginButton)
    }
    
    private func setupConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(106)
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(170)
        }
        
        loginButton.snp.makeConstraints { make in
            make.width.equalTo(343)
            make.height.equalTo(52)
            make.bottom.equalToSuperview().inset(42)
            make.centerX.equalToSuperview()
        }
    }
}
