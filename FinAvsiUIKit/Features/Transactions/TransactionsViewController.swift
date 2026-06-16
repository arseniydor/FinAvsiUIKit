//
//  TransactionsViewController.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import SnapKit
import UIKit

final class TransactionsViewController: BaseViewController {
    private let viewModel: TransactionsViewModel
    private var dataSource: [TransactionsSectionViewModel] = []

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()

    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        return searchController
    }()

    init(viewModel: TransactionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard !searchController.isActive else {
            return
        }

        viewModel.viewWillAppear()
    }

    override func configureAppearance() {
        super.configureAppearance()

        title = "Transactions"
        navigationItem.largeTitleDisplayMode = .automatic

        definesPresentationContext = true

        let addBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        addBarButtonItem.accessibilityIdentifier = "transactions.addButton"
        navigationItem.rightBarButtonItem = addBarButtonItem
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.automaticallyShowsCancelButton = false

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    override func setupViews() {
        super.setupViews()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.reuseIdentifier)
        tableView.accessibilityIdentifier = "transactions.tableView"
        contentView.addSubview(tableView)
    }

    override func setupConstraints() {
        super.setupConstraints()

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func render(_ state: TransactionsViewState) {
        switch state {
        case .loading:
            showLoading()
        case .empty:
            dataSource = []
            tableView.reloadData()
            showEmptyState(
                title: "No transactions yet",
                subtitle: "Add your first income or expense transaction."
            )
        case let .content(sections):
            dataSource = sections
            tableView.reloadData()
            showContent()
        case let .error(message):
            showError(
                message: message
            )
        }
    }

    @objc
    private func addButtonTapped() {
        viewModel.addButtonTapped()
    }

    override func retry() {
        viewModel.viewDidLoad()
    }
}

extension TransactionsViewController: TransactionsViewModelDelegate {
    func transactionsViewModel(_ viewModel: TransactionsViewModel, didChangeState state: TransactionsViewState) {
        render(state)
    }
}

extension TransactionsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.section].rows[indexPath.row] {
        case let .transaction(viewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.reuseIdentifier, for: indexPath) as? TransactionCell else {
                return UITableViewCell()
            }
            cell.configure(with: viewModel)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension TransactionsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchTextDidChange(
            searchController.searchBar.text
        )
    }
}
