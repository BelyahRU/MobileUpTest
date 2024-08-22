//
//  LogiViewController.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 22.08.2024.
//

import Foundation
import UIKit
import WebKit
import SnapKit

class LoginViewController: UIViewController, WKNavigationDelegate {
    
    //MARK: - Properties
    public var coordinator: MainCoordinator!
    public var authView = LoginView()
    public var loginButton: UIButton!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Methods
    private func configure() {
        setupButton() // in extension
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(authView)
        
        authView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


