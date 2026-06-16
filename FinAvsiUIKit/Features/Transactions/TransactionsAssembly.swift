//
//  TransactionsAssembly.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import UIKit

enum TransactionsAssembly {
    static func make(navigationController: UINavigationController?, container: AppContainer) -> UIViewController {
        let router = TransactionsRouter(navigationController: navigationController, container: container)
        let viewModel = TransactionsViewModel(router: router, transactionService: container.transactionService)
        let viewController = TransactionsViewController(viewModel: viewModel)
        return viewController
    }
}
