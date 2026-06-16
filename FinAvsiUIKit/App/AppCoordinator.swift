//
//  AppCoordinator.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let container: AppContainer

    init(window: UIWindow, container: AppContainer) {
        self.window = window
        self.container = container
    }

    func start() {
        let tabBarController = MainTabBarController()

        let mainTabRouter = MainTabRouter(tabBarController: tabBarController)

        container.mainTabRouter = mainTabRouter

        let dashboardNavigationController = UINavigationController()
        let dashboardViewController = makeDashboardViewController(navigationController: dashboardNavigationController)

        dashboardNavigationController.setViewControllers(
            [dashboardViewController],
            animated: false
        )

        dashboardNavigationController.tabBarItem = UITabBarItem(
            title: "Dashboard",
            image: UIImage(systemName: "chart.pie"),
            selectedImage: UIImage(systemName: "chart.pie.fill")
        )

        let transactionsNavigationController = UINavigationController()
        let transactionsViewController = makeTransactionsViewController(navigationController: transactionsNavigationController)

        transactionsNavigationController.setViewControllers(
            [transactionsViewController],
            animated: false
        )

        transactionsNavigationController.tabBarItem = UITabBarItem(
            title: "Transactions",
            image: UIImage(systemName: "list.bullet"),
            selectedImage: UIImage(systemName: "list.bullet")
        )

        tabBarController.viewControllers = [
            dashboardNavigationController,
            transactionsNavigationController,
        ]

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

private extension AppCoordinator {
    func makeDashboardViewController(navigationController: UINavigationController) -> UIViewController {
        DashboardAssembly.make(navigationController: navigationController, container: container)
    }

    func makeTransactionsViewController(navigationController: UINavigationController) -> UIViewController {
        TransactionsAssembly.make(navigationController: navigationController, container: container)
    }
}
