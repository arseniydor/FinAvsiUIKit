//
//  DashboardAssembly.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import UIKit

enum DashboardAssembly {
    static func make(navigationController: UINavigationController?, container: AppContainer) -> UIViewController {
        let router = DashboardRouter(navigationController: navigationController, container: container)
        let viewModel = DashboardViewModel(router: router, analyticsService: container.analyticsService)
        return DashboardViewController(viewModel: viewModel)
    }
}
