# FinAvsiUIKit

<div align="center">

![Swift](https://img.shields.io/badge/Swift-5.10-orange.svg)
![iOS](https://img.shields.io/badge/iOS-17.6%2B-blue.svg)
![UIKit](https://img.shields.io/badge/UIKit-Native-black.svg)
![CoreData](https://img.shields.io/badge/CoreData-Persistence-green.svg)
![Architecture](https://img.shields.io/badge/Architecture-MVVM%20%2B%20Router-purple.svg)
![Tests](https://img.shields.io/badge/Tests-Unit%20%26%20UI-success.svg)
![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)

Personal Finance Tracker built with UIKit and Core Data.

</div>

---

## Screenshots

| Dashboard | Transactions |
|-----------|-------------|
| ![](Screenshots/dashboard.png) | ![](Screenshots/transactions.png) |

| Add Transaction | Transaction Details |
|-----------|-------------|
| ![](Screenshots/add_transaction.png) | ![](Screenshots/transaction_details.png) |

---

## Features

- Add income and expense transactions
- Edit existing transactions
- View transaction details
- Track personal finances
- Category-based analytics
- Monthly financial overview
- Local data persistence
- Modular architecture
- Unit and UI testing

## Tech Stack

- Swift 5.10
- UIKit
- Core Data
- SnapKit
- MVVM
- Coordinator / Router Pattern
- Auto Layout
- XCTest

## Architecture

```text
FinAvsiUIKit
├── App
│   ├── AppCoordinator
│   ├── DependencyContainer
│   └── Application Setup
│
├── Core
│   ├── CoreData
│   ├── Services
│   ├── Navigation
│   ├── Components
│   └── Extensions
│
├── Features
│   ├── Dashboard
│   ├── Transactions
│   ├── TransactionDetails
│   ├── AddTransaction
│   └── EditTransaction
│
├── Models
└── Resources
```

### Architectural Principles

- Feature-first structure
- Dependency Injection
- Separation of Concerns
- Reusable UI Components
- Testable Business Logic

## Core Data

Transactions are stored locally using Core Data.

Supported operations:

- Create transaction
- Read transaction
- Update transaction
- Delete transaction
- Filtering and sorting

## Analytics

The Dashboard provides:

- Total balance
- Monthly income
- Monthly expenses
- Transaction statistics
- Category breakdown

## Testing

Included:

- Unit Tests
- UI Tests

Examples:

```text
AnalyticsServiceTests
TransactionCoreDataServiceTests
```

## Getting Started

### Requirements

- macOS
- Xcode 16+
- iOS 17.6 SDK

## Author

**Arsenii Dorogin**

---

Built with UIKit, Core Data and Clean Architecture principles.
