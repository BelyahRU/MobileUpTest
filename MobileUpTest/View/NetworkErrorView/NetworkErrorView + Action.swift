//
//  File.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 23.08.2024.
//

import Foundation
import UIKit

//MARK: Action
extension NetworkErrorView {
    public func setupButton() {
        loginAgainButton.addTarget(self, action: #selector(didTapLoginAgainButton), for: .touchUpInside)
    }
    
    @objc private func didTapLoginAgainButton() {
        delegate?.didTapLoginAgainButton()
    }
}
