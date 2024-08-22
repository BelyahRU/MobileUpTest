//
//  AuthCoordinator.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 22.08.2024.
//

import Foundation
import UIKit
// Главный координатор
class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = [] // Массив для хранения дочерних координаторов
    var loginViewController: LoginViewController!
    
    init() {
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        let shared = AuthManager.shared
        
        if shared.isSignedIn && !shared.shouldRefreshToken {
            showMain()
        } else {
            showLogin()
        }
    }
    
    public func showLogin() {
        print("coordinators: \(childCoordinators)")
        loginViewController = LoginViewController()
        loginViewController.coordinator = self
        navigationController.pushViewController(loginViewController, animated: false)
    }
    
    public func showAuthorization() {
        
        let loginVC = AuthorizationViewController()
        loginVC.coordinator = self
        
        loginVC.authCompletion = { [weak self] success in
            if success {
                self?.start()
            } else {
                self?.showErrorAuthMessage()
            }
        }
        
        loginVC.modalPresentationStyle = .fullScreen
        navigationController.present(loginVC, animated: true, completion: nil)
        
    }
    
    public func showMain() {
        //ADD: - добавить сюда экран с фото видео
    }
    
    private func showErrorAuthMessage() {
        
        let title = "Ошибка авторизации"
        let message = "Авторизация прошла с ошибкой. Попробуйте познее"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        
        navigationController.present(alert, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        // Удаляем дочерний координатор из массива, когда он завершает свою работу
        guard let child = child else { return }
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
