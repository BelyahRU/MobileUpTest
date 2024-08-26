//
//  VideoViewController.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation
import UIKit
import WebKit

class VideoViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    //MARK: - Properties
    var videoItem: Video?
    public var videoView = VideoView()
    public var webView: WKWebView!
    public var shareButton: UIButton!
    public var backButton: UIButton!
    public var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Methos
    private func configure() {
        setupActivityIndicator()
        setupButtons()
        setupData()
        setupWebView()
        setupSubviews()
        setupConstraints()
        
        guard let videoItem = videoItem, let url = URL(string: videoItem.urlPlayer) else {
                showErrorAlert(message: "Не удалось загрузить видео. Неверный URL.")
                return
            }
                
        webView.load(URLRequest(url: url))
    }
    
    private func setupData() {
        videoView.setupData(title: videoItem?.titleVideo ?? "")
    }
    
    private func setupWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = false
        webConfiguration.allowsAirPlayForMediaPlayback = true
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    private func setupActivityIndicator() {
        activityIndicator = videoView.activityIndicator
        activityIndicator.startAnimating()
    }
    
    private func setupSubviews() {
        view.addSubview(videoView)
        videoView.addSubview(webView)
    }
    
    private func setupConstraints() {
        videoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        webView.snp.makeConstraints { make in
            make.top.equalTo(videoView.lineView.snp.bottom)
            make.trailing.leading.bottom.equalToSuperview()
        }
    }
}
