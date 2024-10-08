//
//  MainVC + Action.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 25.08.2024.
//

import Foundation
import UIKit

//MARK: - Action
extension MainViewController {
    
    public func setupActions() {
        signOutButton.addTarget(self, action: #selector(signOutPressed), for: .touchUpInside)
        segmentControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
    }
    
    @objc
    func signOutPressed() {
        coordinator?.didTapLogout()
    }
    
    @objc 
    func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("[LOGGER][MainViewController]: Photos selected")
            setupPhotosLayout()
            contentCollectionView.reloadData()
        case 1:
            print("[LOGGER][MainViewController]: Videos selected")
            setupVideosLayout()
            contentCollectionView.reloadData()
        default:
            break
        }
    }
}
