//
//  MainTabRouter.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import UIKit

protocol MainTabRouting: AnyObject {
    func showDashboard()
    func showTransactions()
}

final class MainTabRouter: MainTabRouting {
    private weak var tabBarController: UITabBarController?

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func showDashboard() {
        tabBarController?.selectedIndex = 0
    }

    func showTransactions() {
        tabBarController?.selectedIndex = 1
    }
}
