//
//  TransactionDetailsAssembly.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import UIKit

enum TransactionDetailsAssembly {
    static func make(transactionId: UUID, navigationController: UINavigationController?, container: AppContainer) -> UIViewController {
        let router = TransactionDetailsRouter(navigationController: navigationController, container: container)
        let viewModel = TransactionDetailsViewModel(transactionId: transactionId, router: router, transactionService: container.transactionService)
        return TransactionDetailsViewController(viewModel: viewModel)
    }
}
