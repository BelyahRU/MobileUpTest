//
//  AuthViewModel.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 25.08.2024.
//

import Foundation
final class AuthViewModel {
    
    private let authManager = AuthManager.shared
    
    func isUserSignedIn() -> Bool {
        return authManager.isSignedIn && !authManager.shouldRefreshToken
    }
    
    func signOut(completion: @escaping (Bool) -> Void) {
        authManager.signOut(completion: completion)
    }
}
