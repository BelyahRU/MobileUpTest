//
//  VideoVC + WebView.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation
import UIKit
import WebKit

//MARK: WebView

extension VideoViewController {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        let fullScreenWebView = WKWebView(frame: self.view.bounds, configuration: configuration)
            fullScreenWebView.uiDelegate = self
            fullScreenWebView.navigationDelegate = self
            self.view.addSubview(fullScreenWebView)
        return fullScreenWebView
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
        
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        showErrorAlert(message: "Не удалось загрузить видео. Пожалуйста, попробуйте позже.")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        showErrorAlert(message: "Не удалось загрузить видео. Проверьте подключение к интернету и попробуйте снова.")
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        webView.removeFromSuperview()
    }
    
    func showErrorAlert(message: String) {
            let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true)
        }
    
}


