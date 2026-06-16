//
//  AddTransactionAssembly.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import UIKit

enum AddTransactionAssembly {
    static func make(navigationController: UINavigationController?, container: AppContainer) -> UIViewController {
        let router = AddTransactionRouter(navigationController: navigationController, container: container)
        let viewModel = AddTransactionViewModel(router: router, transactionService: container.transactionService)
        let viewController = AddTransactionViewController(viewModel: viewModel)
        return viewController
    }
}
