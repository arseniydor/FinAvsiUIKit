//
//  DashboardViewController.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import SnapKit
import UIKit

final class DashboardViewController: BaseViewController {
    private let viewModel: DashboardViewModel
    private var dataSource: [DashboardSectionViewModel] = []

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        return tableView
    }()

    init(viewModel: DashboardViewModel) {
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
        viewModel.viewWillAppear()
    }

    override func configureAppearance() {
        super.configureAppearance()

        title = "Dashboard"
        navigationItem.largeTitleDisplayMode = .automatic
    }

    override func setupViews() {
        super.setupViews()

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(DashboardMonthCell.self, forCellReuseIdentifier: DashboardMonthCell.reuseIdentifier)

        tableView.register(DashboardSummaryCell.self, forCellReuseIdentifier: DashboardSummaryCell.reuseIdentifier)

        tableView.register(DashboardCategoryCell.self, forCellReuseIdentifier: DashboardCategoryCell.reuseIdentifier)

        tableView.register(DashboardButtonCell.self, forCellReuseIdentifier: DashboardButtonCell.reuseIdentifier)

        tableView.register(DashboardEmptyCategoryCell.self, forCellReuseIdentifier: DashboardEmptyCategoryCell.reuseIdentifier)

        contentView.addSubview(tableView)
    }

    override func setupConstraints() {
        super.setupConstraints()

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func render(_ state: DashboardViewState) {
        switch state {
        case .loading:
            showLoading()
        case let .content(sections):
            dataSource = sections
            tableView.reloadData()
            showContent()
        case let .error(message):
            showError(message: message)
        }
    }

    @objc
    private func previousMonthButtonTapped() {
        viewModel.previousMonthTapped()
    }

    @objc
    private func nextMonthButtonTapped() {
        viewModel.nextMonthTapped()
    }

    override func retry() {
        viewModel.viewDidLoad()
    }
}

extension DashboardViewController: DashboardViewModelDelegate {
    func dashboardViewModel(_ viewModel: DashboardViewModel, didChangeState state: DashboardViewState) {
        render(state)
    }
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource[section].rows.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch dataSource[section].section {
        case .month:
            return nil
        case .summary:
            return "Summary"
        case .categories:
            return "Categories"
        case .actions:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.section].rows[indexPath.row] {
        case let .month(monthTitle):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DashboardMonthCell.reuseIdentifier, for: indexPath) as? DashboardMonthCell else {
                return UITableViewCell()
            }
            cell.configure(monthTitle: monthTitle)
            cell.delegate = self
            return cell
        case let .summary(title, value):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DashboardSummaryCell.reuseIdentifier, for: indexPath) as? DashboardSummaryCell else {
                return UITableViewCell()
            }
            cell.configure(title: title, value: value)
            return cell
        case let .category(category):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DashboardCategoryCell.reuseIdentifier, for: indexPath) as? DashboardCategoryCell else {
                return UITableViewCell()
            }
            cell.configure(with: category)
            return cell
        case .emptyCategories:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DashboardEmptyCategoryCell.reuseIdentifier, for: indexPath) as? DashboardEmptyCategoryCell else {
                return UITableViewCell()
            }
            cell.configure(text: "No expense categories yet")
            return cell
        case .transactionsButton:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DashboardButtonCell.reuseIdentifier, for: indexPath) as? DashboardButtonCell else {
                return UITableViewCell()
            }
            cell.configure(title: "View Transactions")
            cell.delegate = self
            return cell
        }
    }
}

extension DashboardViewController: DashboardMonthCellDelegate, DashboardButtonCellDelegate {
    func previousAction() {
        previousMonthButtonTapped()
    }

    func nextAction() {
        nextMonthButtonTapped()
    }

    func didTapDashboardButtonCell() {
        viewModel.transactionsTapped()
    }
}
