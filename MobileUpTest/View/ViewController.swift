//
//  ViewController.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 22.08.2024.
//

import UIKit
import WebKit
import VKID
import VKIDCore

import UIKit
import VKIDCore

class ViewController: UIViewController{
    

    // MARK: - Properties
    private var vkid: VKID!

    // MARK: - UI Elements
    private let authButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти с VK ID", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(authButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupVKid()
        setupUI()
    }

    // MARK: - Setup
    private func setupVKid() {
        do {
            self.vkid = try VKID(
                config: Configuration(
                    appCredentials: AppCredentials(
                        clientId: "52194798",         // ID вашего приложения
                        clientSecret: "6zu9hvfv8en3cdimE8is"  // ваш защищенный ключ (client_secret)
                    )
                )
            )
            vkid.add(observer: self)
        } catch {
            fatalError("Не удалось инициализировать VKID: \(error)")
        }
    }

    private func setupUI() {
        view.addSubview(authButton)
        NSLayoutConstraint.activate([
            authButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            authButton.widthAnchor.constraint(equalToConstant: 220),
            authButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Actions
    @objc private func authButtonTapped() {
        startAuthProcess()
    }

    private func startAuthProcess() {
        vkid.authorize(
            with: makeAuthConfiguration(),
            using: .uiViewController(self)
        ) { result in
            switch result {
            case .success(let session):
                print("Авторизация прошла успешно: \(session)")
                self.showAlert(title: "Успех", message: "Авторизация прошла успешно")
            case .failure(let error):
                if case AuthError.cancelled = error {
                    print("Авторизация отменена пользователем")
                } else {
                    print("Ошибка авторизации: \(error)")
                    self.showAlert(title: "Ошибка", message: "Не удалось авторизироваться: \(error.localizedDescription)")
                }
            }
        }
    }

    private func makeAuthConfiguration() -> AuthConfiguration {
        return AuthConfiguration(
            flow: .publicClientFlow(),
            scope: Scope(["email", "profile"]) // Укажите необходимые scope
        )
    }

    // MARK: - Helper Methods
    public func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - VKIDObserver
extension ViewController: VKIDObserver {
    func vkid(_ vkid: VKID, didLogoutFrom session: UserSession, with result: LogoutResult) {
        print("Пользователь вышел из системы.")
    }

    func vkid(_ vkid: VKID, didStartAuthUsing oAuth: OAuthProvider) {
        print("Началась авторизация через \(oAuth)")
    }

    func vkid(_ vkid: VKID, didCompleteAuthWith result: AuthResult, in oAuth: OAuthProvider) {
        switch result {
        case .success(let session):
            print("Успешная авторизация через \(oAuth): \(session)")
            showAlert(title: "Успех", message: "Авторизация прошла успешно!")
        case .failure(let error):
            print("Ошибка авторизации через \(oAuth): \(error)")
            showAlert(title: "Ошибка", message: "Авторизация не удалась: \(error.localizedDescription)")
        }
    }
}
