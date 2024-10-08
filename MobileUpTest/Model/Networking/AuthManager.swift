//
//  AuthManager.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 23.08.2024.
//

import Foundation

class AuthManager {
    
    static let shared = AuthManager()
    
    struct NetworkConstants {
        static let app_id = "52194798" //app_id
    }
    
    public var authURL: URL? {
        return URL(string: "https://oauth.vk.com/authorize?client_id=\(NetworkConstants.app_id)&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&scope=photos,video,groups&revoke=1&response_type=token&v=5.131")
    }
    
    public var isSignedIn: Bool {
        return accessToken != nil
    }
    
    //MARK: - токен
    public var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
//        return "vk1.a.VGcV-wcRZjisSG-xf9cF1StT0SsACHsmSY8bpOhPLfch3ua_-M3xiaRcCorni7UAwOaW6XHm2xruqBMCjDbg6DDbxxzL6K7NZefk1FDgQNV-b31BGUthqI9EcaLKgQgoeG2YL2RMwkZQgaoJhMcxf3UXBHNl6ZbKHn6QMGEJzRBa4v5ibbkMuJNm-JDvEDsHu5sGLV1VM468DWUvcg81VA"
    }
    
    //MARK: - дата окончания действия токена
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expires_in") as? Date
    }
    
    
    //MARK: - проверяем закончилось ли действие токена
    public var shouldRefreshToken: Bool {
        
        guard let expirationDate = tokenExpirationDate else {
            print("[LOGGER][AuthManager]: Token expiration date is end.")
            return false
        }
        
        let currentDate = Date()
        return currentDate >= expirationDate
    }
    
    
    //MARK: - авторизация
    public func authorization(with redirectString: String, completion: @escaping (Bool) -> Void) {
        // Разделяем строку перенаправления по символу "#" и проверяем, есть ли вторая часть
        let components = redirectString.split(separator: "#", maxSplits: 1, omittingEmptySubsequences: false)
        
        // Убедимся, что у нас есть часть с параметрами
        guard components.count > 1 else {
            print("[LOGGER][AuthManager][Authorization]: String components <= 1.")
            completion(false)
            return
        }
        
        // Получаем параметры после "#"
        let parametersString = components[1]
        
        // Разделяем параметры по "&" и преобразуем в словарь
        let parameters = parametersString.split(separator: "&")
            .reduce(into: [String: String]()) { result, item in
                let keyValue = item.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false)
                if keyValue.count == 2 {
                    let key = String(keyValue[0])
                    let value = String(keyValue[1])
                    result[key] = value
                }
            }
        
        // Извлекаем токен и время действия
        guard let accessToken = parameters["access_token"],
              let expiresDateString = parameters["expires_in"],
              let expiresIn = Int(expiresDateString) else {
            print("[LOGGER][AuthManager][Authorization]: Error with extracting token parameters.")
            completion(false)
            return
        }
        
        // Сохраняем токен и время его действия
        saveToken(with: accessToken, and: expiresIn)
        
        // Сообщаем об успешной авторизации
        completion(true)
        print("[LOGGER][AuthManager]: Auth success.")
    }

    
    //MARK: - выход из аккаунта
    public func signOut(completion: @escaping (Bool) -> Void) {
        
        UserDefaults.standard.set(nil, forKey: "access_token")
        
        UserDefaults.standard.setValue(nil, forKey: "expires_in")
        
        completion(true)
        print("[LOGGER][AuthManager]: User signed out.")
    }
    
    
    //MARK: - сохранение токена и даты окончания его действия
    private func saveToken(with token: String, and expires_in: Int) {
        
        UserDefaults.standard.setValue(token, forKey: "access_token")
        
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(expires_in)), forKey: "expires_in")
        print("[LOGGER][AuthManager]: Token saved.")
    }

}
