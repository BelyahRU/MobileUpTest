//
//  AuthorizationVC + WKNavigationDelegate.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 23.08.2024.
//

import Foundation
import UIKit
import WebKit

//MARK: - WKNavigationDelegate
extension AuthorizationViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {

        webView.isHidden = true
        activityIndicator.stopAnimating()
        
        noConnectionView.isHidden = false
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        if webView.isHidden {
            webView.isHidden = false
        }
        
        activityIndicator.stopAnimating()
        if !noConnectionView.isHidden {
            noConnectionView.isHidden = true
        }
        
        guard let redirectString = webView.url?.absoluteString else {
            return
        }

        if redirectString.hasPrefix("https://oauth.vk.com/blank.html#error=") {
            
            self.dismiss(animated: true) {
                self.authCompletion?(false)
            }
            return
        }
        
        guard redirectString.hasPrefix("https://oauth.vk.com/blank.html#access_token=") else {
            return
        }
        
        webView.isHidden = true

        AuthManager.shared.authorization(with: redirectString) { [weak self] (success) in
            
            self?.dismiss(animated: true) {
                self?.authCompletion?(success)
            }
        }
    }
}
