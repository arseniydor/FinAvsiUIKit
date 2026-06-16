//
//  Route.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import UIKit

protocol Route {
    func makeViewController(navigationController: UINavigationController?, container: AppContainer) -> UIViewController
}
