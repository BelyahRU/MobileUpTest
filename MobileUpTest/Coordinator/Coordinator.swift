//
//  Coordinator.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 22.08.2024.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
