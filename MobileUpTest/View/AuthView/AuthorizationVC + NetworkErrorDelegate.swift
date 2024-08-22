//
//  AuthorizationVC + NetworkErrorDelegate.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 23.08.2024.
//

import Foundation

//MARK: - NetworkErrorViewDelegate
extension AuthorizationViewController: NetworkErrorViewDelegate {
    func didTapLoginAgainButton() {
        noConnectionView.isHidden = true
        webView.isHidden = false
        loadRequest()
    }
}
