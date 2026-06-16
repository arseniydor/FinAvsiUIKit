//
//  BaseRouter.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import UIKit

class BaseRouter {
    weak var navigationController: UINavigationController?
    let container: AppContainer

    init(navigationController: UINavigationController?, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }

    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }

    func present(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.present(viewController, animated: animated)
    }

    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }

    func dismiss(animated: Bool = true) {
        navigationController?.dismiss(animated: animated)
    }
}

extension BaseRouter {
    func push(_ route: Route, animated: Bool = true) {
        let viewController = route.makeViewController(navigationController: navigationController, container: container)
        push(viewController, animated: animated)
    }

    func present(_ route: Route, animated: Bool = true) {
        let viewController = route.makeViewController(navigationController: navigationController, container: container)
        present(viewController, animated: animated)
    }
}
