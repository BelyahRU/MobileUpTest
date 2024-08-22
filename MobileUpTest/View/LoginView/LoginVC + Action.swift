//
//  AuthVC + Action.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 23.08.2024.
//

import Foundation
import UIKit

//MARK: - Action
extension LoginViewController {
    public func setupButton() {
        loginButton = authView.loginButton
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
    }
    
    @objc
    func loginPressed() {
        coordinator?.showAuthorization()
    }
}
