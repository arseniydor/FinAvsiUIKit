//
//  AddTransactionRouter.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import Foundation

protocol AddTransactionRouting: AnyObject {
    func close()
}

final class AddTransactionRouter: BaseRouter, AddTransactionRouting {
    func close() {
        pop()
    }
}
