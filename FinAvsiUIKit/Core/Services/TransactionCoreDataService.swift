//
//  TransactionCoreDataService.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import CoreData
import Foundation

final class TransactionCoreDataService: TransactionServiceProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func fetchTransactions() throws -> [Transaction] {
        try fetchTransactions(filter: TransactionFilter())
    }

    func fetchTransactions(filter: TransactionFilter) throws -> [Transaction] {
        let request = TransactionEntity.fetchRequest()

        request.predicate = makePredicate(from: filter)

        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]

        let entities = try context.fetch(request)

        return entities.map { mapEntityToModel($0) }
    }

    func createTransaction(_ transaction: Transaction) throws {
        let entity = TransactionEntity(context: context)
        mapModelToEntity(transaction, entity: entity)

        try save()
    }

    func updateTransaction(_ transaction: Transaction) throws {
        let entity = try fetchEntity(id: transaction.id)
        mapModelToEntity(transaction, entity: entity)

        try save()
    }

    func deleteTransaction(id: UUID) throws {
        let entity = try fetchEntity(id: id)
        context.delete(entity)

        try save()
    }

    func fetchTransaction(id: UUID) throws -> Transaction {
        let entity = try fetchEntity(id: id)
        return mapEntityToModel(entity)
    }
}

private extension TransactionCoreDataService {
    func fetchEntity(id: UUID) throws -> TransactionEntity {
        let request = TransactionEntity.fetchRequest()

        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        guard let entity = try context.fetch(request).first else {
            throw TransactionRepositoryError.transactionNotFound
        }

        return entity
    }

    func mapEntityToModel(_ entity: TransactionEntity) -> Transaction {
        Transaction(
            id: entity.id ?? UUID(),
            amount: entity.amount,
            type: TransactionType(rawValue: entity.type ?? "") ?? .expense,
            category: entity.category ?? "",
            title: entity.title ?? "",
            description: entity.transactionDescription,
            paymentMethod: PaymentMethod(rawValue: entity.paymentMethod ?? "") ?? .cash,
            date: entity.date ?? Date(),
            createdAt: entity.createdAt ?? Date(),
            updatedAt: entity.updatedAt ?? Date()
        )
    }

    func mapModelToEntity(_ transaction: Transaction, entity: TransactionEntity) {
        entity.id = transaction.id
        entity.amount = transaction.amount
        entity.type = transaction.type.rawValue
        entity.category = transaction.category
        entity.title = transaction.title
        entity.transactionDescription = transaction.description
        entity.paymentMethod = transaction.paymentMethod.rawValue
        entity.date = transaction.date
        entity.createdAt = transaction.createdAt
        entity.updatedAt = transaction.updatedAt
    }

    func save() throws {
        guard context.hasChanges else {
            return
        }

        try context.save()
    }

    private func makePredicate(from filter: TransactionFilter) -> NSPredicate? {
        var predicates: [NSPredicate] = []

        if let startDate = filter.startDate {
            predicates.append(NSPredicate(format: "date >= %@", startDate as NSDate))
        }

        if let endDate = filter.endDate {
            predicates.append(NSPredicate(format: "date <= %@", endDate as NSDate))
        }

        if let type = filter.type {
            predicates.append(NSPredicate(format: "type == %@", type.rawValue))
        }

        if let paymentMethod = filter.paymentMethod {
            predicates.append(NSPredicate(format: "paymentMethod == %@", paymentMethod.rawValue))
        }

        if let minAmount = filter.minAmount {
            predicates.append(NSPredicate(format: "amount >= %lf", minAmount))
        }

        if let maxAmount = filter.maxAmount {
            predicates.append(NSPredicate(format: "amount <= %lf", maxAmount))
        }

        if let searchText = filter.searchText?.trimmingCharacters(in: .whitespacesAndNewlines), !searchText.isEmpty {
            let searchPredicate = NSCompoundPredicate(
                orPredicateWithSubpredicates: [
                    NSPredicate(format: "title CONTAINS[cd] %@", searchText),
                    NSPredicate(format: "category CONTAINS[cd] %@", searchText),
                    NSPredicate(format: "transactionDescription CONTAINS[cd] %@", searchText),
                    NSPredicate(format: "type CONTAINS[cd] %@", searchText),
                    NSPredicate(format: "paymentMethod CONTAINS[cd] %@", searchText),
                ]
            )

            predicates.append(searchPredicate)
        }

        guard !predicates.isEmpty else {
            return nil
        }

        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }
}
