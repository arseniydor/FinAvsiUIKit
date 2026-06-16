//
//  MainTabBarController.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }

    private func configureAppearance() {
        view.backgroundColor = .systemBackground
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .label
    }
}
