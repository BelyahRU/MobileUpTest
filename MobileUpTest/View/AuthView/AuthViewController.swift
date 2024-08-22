//
//  AuthViewController.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 22.08.2024.
//

import Foundation
import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var coordinator: AuthCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupUI() {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.websiteDataStore = WKWebsiteDataStore.default() //для сохранения куки

        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view.addSubview(webView)

        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    public func setupUrl(urlString: String) {
        // Загрузка URL
        print(urlString)
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        } else if let url = URL(string: "https://www.google.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Страница загружена")
    }
}
