//
//  TransactionDetailsViewController.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import SnapKit
import UIKit

final class TransactionDetailsViewController: BaseViewController {
    private let viewModel: TransactionDetailsViewModel

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        return label
    }()

    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()

    private let paymentMethodLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()

    init(viewModel: TransactionDetailsViewModel) {
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

        title = "Transaction"
        navigationItem.largeTitleDisplayMode = .never
        let editBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(editButtonTapped)
        )
        editBarButtonItem.accessibilityIdentifier = "transactionDetails.editButton"
        
        navigationItem.rightBarButtonItem = editBarButtonItem
    }

    override func setupViews() {
        super.setupViews()
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(paymentMethodLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(descriptionLabel)
        categoryLabel.accessibilityIdentifier = "transactionDetails.categoryLabel"
        titleLabel.accessibilityIdentifier = "transactionDetails.titleLabel"
    }

    override func setupConstraints() {
        super.setupConstraints()

        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }

    private func render(_ state: TransactionDetailsViewState) {
        switch state {
        case let .error(message):
            showError(message: message)
        case let .content(content):
            amountLabel.text = content.amount
            titleLabel.text = content.title
            typeLabel.text = "Type: \(content.type)"
            categoryLabel.text = "Category: \(content.category)"
            paymentMethodLabel.text = "Payment: \(content.paymentMethod)"
            dateLabel.text = "Date: \(content.date)"
            descriptionLabel.text = "Description: \(content.description ?? "—")"

            showContent()
        }
    }

    @objc
    private func editButtonTapped() {
        viewModel.editButtonTapped()
    }

    override func retry() {
        viewModel.viewDidLoad()
    }
}

extension TransactionDetailsViewController: TransactionDetailsViewModelDelegate {
    func transactionDetailsViewModel(_ viewModel: TransactionDetailsViewModel, didChangeState state: TransactionDetailsViewState) {
        render(state)
    }
}
