//
//  AuthCoordinator.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 22.08.2024.
//

import Foundation
import UIKit
// Главный координатор
class AuthCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = [] // Массив для хранения дочерних координаторов
//    var detailCoordinator: MainTabBarCoordinator!
    var authViewController: AuthViewController!
    
    init() {
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        
    }
    
    public func showAuth() {
        print("coordinators: \(childCoordinators)")
        authViewController = AuthViewController()
        authViewController.coordinator = self
        navigationController.pushViewController(authViewController, animated: false)
    }
    
    func showMain() {
       
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
