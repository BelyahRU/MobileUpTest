//
//  MainView.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 25.08.2024.
//

import Foundation
import UIKit
import SnapKit

class MainView: UIView {
    
    //MARK: Properties
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "MobileUp Gallery"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    public let signOutButton: UIButton = {
       let button = UIButton()
        button.setTitle("Выход", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    public let photoVideoSegmentPicker: UISegmentedControl = {
        let items = ["Фото", "Видео"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.backgroundColor = .white
        return control
    }()
    
    
    
    //MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    private func configure() {
        setupUI()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupUI() {
        backgroundColor = .white
    }
    
    private func setupSubviews() {
        addSubview(headerTitleLabel)
        addSubview(signOutButton)
        addSubview(photoVideoSegmentPicker)
    }
    
    private func setupConstraints() {
        headerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(6)
        }
        
        signOutButton.snp.makeConstraints { make in
            make.centerY.equalTo(headerTitleLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(12)
        }
        
        photoVideoSegmentPicker.snp.makeConstraints { make in
            make.top.equalTo(headerTitleLabel.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
    }
}
