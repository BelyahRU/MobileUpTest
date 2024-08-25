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
    var childCoordinators: [Coordinator] = []
    let viewModel = AuthViewModel()
    
    var authCoordinator: AuthCoordinator!
    var mainViewController: MainViewController!
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        if viewModel.isUserSignedIn() {
            print("[LOGGER][MainCoordinator]: User singned in.")
            showMain()
        } else {
            print("[LOGGER][MainCoordinator]: User not singned in or token should refresh.")
            startAuthFlow()
        }
    }
    
    //MARK: - AuthCoordinator
    private func startAuthFlow() {
        authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator.parentCoordinator = self
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
        print("[LOGGER][MainCoordinator]: AuthCoordinator started.")
    }
    
    //MARK: - MainViewController
    private func showMain() {
        mainViewController = MainViewController()
        mainViewController.coordinator = self
        navigationController.pushViewController(mainViewController, animated: true)
        print("[LOGGER][MainCoordinator]: MainViewController loaded.")
    }
    
    //MARK: - Sign out
    func didTapLogout() {
        print("[LOGGER][MainCoordinator]: User tapped logout.")
        viewModel.signOut { [weak self] success in
            if success {
                self?.navigationController.popToRootViewController(animated: true)
                self?.startAuthFlow()
            } else {
                self?.showErrorSignOutMessage()
            }
        }
    }
    
    //MARK: - Sign out error
    private func showErrorSignOutMessage() {
        let title = "Ошибка выхода"
        let message = "Не удалось выйти из аккаунта. Попробуйте ещё раз."
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        
        navigationController.present(alert, animated: true)
        print("[LOGGER][MainCoordinator]: SignOutError. AlertController loaded.")
    }
}
