//
//  SceneDelegate.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 22.08.2024.
//

import UIKit
import VKID
import VKIDCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator!
    var vkid: VKID!
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        setupVKid()
        
        coordinator = MainCoordinator()
        coordinator.start() // Запускаем координатор
            
        self.window?.rootViewController = coordinator.navigationController
        self.window?.makeKeyAndVisible()
        
    }
    
    func setupVKid() {
        do {
            self.vkid = try VKID(
                config: Configuration(
                    appCredentials: AppCredentials(
                        clientId: "52194798",         // ID вашего приложения
                        clientSecret: "6zu9hvfv8en3cdimE8is"  // ваш защищенный ключ (client_secret)
                    )
                )
            )
        } catch {
            preconditionFailure("Failed to initialize VKID: \(error)")
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

