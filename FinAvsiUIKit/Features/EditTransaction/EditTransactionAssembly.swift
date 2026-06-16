//
//  EditTransactionAssembly.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import UIKit

enum EditTransactionAssembly {
    static func make(transaction: Transaction, navigationController: UINavigationController?, container: AppContainer) -> UIViewController {
        let router = EditTransactionRouter(navigationController: navigationController, container: container)
        let viewModel = EditTransactionViewModel(transaction: transaction, router: router, transactionService: container.transactionService)
        return EditTransactionViewController(viewModel: viewModel)
    }
}
