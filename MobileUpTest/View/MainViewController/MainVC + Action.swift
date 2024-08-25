//
//  MainVC + Action.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 25.08.2024.
//

import Foundation
import UIKit

//MARK: - Action
extension MainViewController {
    
    public func setupButtons() {
        signOutButton = mainView.signOutButton
        signOutButton.addTarget(self, action: #selector(signOutPressed), for: .touchUpInside)
    }
    
    @objc
    func signOutPressed() {
        coordinator?.didTapLogout()
    }
}
