//
//  AuthCoordinator.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 25.08.2024.
//

import Foundation
import UIKit

class AuthCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLogin()
    }
    
    private func showLogin() {
        let loginViewController = LoginViewController()
        loginViewController.coordinator = self
        navigationController.pushViewController(loginViewController, animated: true)
        print("[LOGGER][AuthCoordinator]: LoginViewController loaded.")
    }
    
    public func showAuthorization() {
        let authViewController = AuthorizationViewController()
        authViewController.coordinator = self
        
        authViewController.authCompletion = { [weak self] success in
            if success {
                self?.parentCoordinator?.start() // Возвращаемся к главному координатору
            } else {
                self?.showErrorAuthMessage()
            }
        }
        
        authViewController.modalPresentationStyle = .fullScreen
        navigationController.present(authViewController, animated: true)
        print("[LOGGER][AuthCoordinator]: AuthorizationViewController loaded.")
    }
    
    private func showErrorAuthMessage() {
        let title = "Ошибка авторизации"
        let message = "Авторизация прошла с ошибкой. Попробуйте позднее"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        
        navigationController.present(alert, animated: true)
        print("[LOGGER][AuthCoordinator]: AuthError. AlertController loaded.")
    }
}
