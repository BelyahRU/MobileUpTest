//
//  MainViewController.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 25.08.2024.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    //MARK: Properties
    weak var coordinator: MainCoordinator?

    public var mainView = MainView()
    public var signOutButton: UIButton!
    public var segmentControl: UISegmentedControl!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: Methods
    private func configure() {
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
