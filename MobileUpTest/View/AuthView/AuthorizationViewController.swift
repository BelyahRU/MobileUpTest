//
//  LoginViewController.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 23.08.2024.
//

import Foundation
import UIKit
import WebKit

class AuthorizationViewController: UIViewController{
    
    //MARK: - Properties
    var coordinator: AuthCoordinator?
    
    public let noConnectionView: NetworkErrorView = {
        let view = NetworkErrorView()
        view.isHidden = true
        return view
    }()
    
    public let webView: WKWebView = {
        let web = WKWebView()
        return web
    }()
    
    public let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .large
        return indicator
    }()
    
    //MARK: - auth completion
    public var authCompletion: ((Bool) -> Void)?

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Methods
    private func configure() {
        setupUI()
        setupDelegate()
        setupSubviews()
        setupConstraints()
        
        loadRequest()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    private func setupDelegate() {
        webView.navigationDelegate = self
        noConnectionView.delegate = self
    }
    
    private func setupSubviews() {
        view.addSubview(webView)
        view.addSubview(noConnectionView)
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        webView.snp.makeConstraints { (make) in
            make.leading.top.bottom.trailing.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        noConnectionView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalToSuperview().dividedBy(2)
        }
    }
    
    //MARK: - loading webView
    public func loadRequest() {
        guard let url = AuthManager.shared.authURL else { return }
        activityIndicator.startAnimating()
        webView.load(URLRequest(url: url))
    }

}

