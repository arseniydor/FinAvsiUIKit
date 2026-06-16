//
//  AppContainer.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import CoreData
import UIKit

final class AppContainer {
    private let persistenceController: PersistenceController

    lazy var transactionService: TransactionServiceProtocol = {
        TransactionCoreDataService(
            context: persistenceController.viewContext
        )
    }()

    lazy var analyticsService: AnalyticsServiceProtocol = {
        AnalyticsService(
            transactionService: transactionService
        )
    }()

    var viewContext: NSManagedObjectContext {
        persistenceController.viewContext
    }

    var mainTabRouter: MainTabRouting?

    init(persistenceController: PersistenceController = PersistenceController()) {
        self.persistenceController = persistenceController
    }

    func saveContext() {
        persistenceController.saveContext()
    }
}
