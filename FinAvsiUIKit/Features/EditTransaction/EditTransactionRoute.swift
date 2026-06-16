//
//  EditTransactionRoute.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import UIKit

struct EditTransactionRoute: Route {
    let transaction: Transaction

    func makeViewController(navigationController: UINavigationController?, container: AppContainer) -> UIViewController {
        EditTransactionAssembly.make(transaction: transaction, navigationController: navigationController, container: container)
    }
}
