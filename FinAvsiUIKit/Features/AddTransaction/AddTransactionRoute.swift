//
//  AddTransactionRoute.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import UIKit

struct AddTransactionRoute: Route {
    func makeViewController(navigationController: UINavigationController?, container: AppContainer) -> UIViewController {
        AddTransactionAssembly.make(navigationController: navigationController, container: container)
    }
}
