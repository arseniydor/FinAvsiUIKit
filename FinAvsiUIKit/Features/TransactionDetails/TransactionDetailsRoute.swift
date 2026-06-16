//
//  TransactionDetailsRoute.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import UIKit

struct TransactionDetailsRoute: Route {
    let transactionId: UUID

    func makeViewController(navigationController: UINavigationController?, container: AppContainer) -> UIViewController {
        TransactionDetailsAssembly.make(transactionId: transactionId, navigationController: navigationController, container: container)
    }
}
