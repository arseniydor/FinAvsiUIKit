//
//  TestFactory.swift
//  FinAvsiUIKitTests
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

@testable import FinAvsiUIKit
import XCTest

final class TestFactory {

    static func makeContainer() -> AppContainer {
        AppContainer(
            persistenceController: PersistenceController(inMemory: true)
        )
    }
}
