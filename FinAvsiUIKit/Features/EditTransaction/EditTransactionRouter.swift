//
//  EditTransactionRouter.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import Foundation

protocol EditTransactionRouting: AnyObject {
    func close()
}

final class EditTransactionRouter: BaseRouter, EditTransactionRouting {
    func close() {
        pop()
    }
}
