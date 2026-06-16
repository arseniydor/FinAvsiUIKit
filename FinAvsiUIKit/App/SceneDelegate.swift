//
//  SceneDelegate.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let window = UIWindow(windowScene: windowScene)
        let isUITesting = CommandLine.arguments.contains("-ui-testing")
        
        let container = AppContainer(
            persistenceController: PersistenceController(
                inMemory: isUITesting
            )
        )

        let coordinator = AppCoordinator(
            window: window,
            container: container
        )

        self.window = window
        appCoordinator = coordinator

        coordinator.start()
    }
}
