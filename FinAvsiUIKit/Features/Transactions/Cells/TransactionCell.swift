//
//  TransactionCell.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import SnapKit
import UIKit

final class TransactionCell: BaseTableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        return label
    }()

    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .right
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        return label
    }()

    override func setupViews() {
        super.setupViews()
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(dateLabel)
    }

    override func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(16)
            make.trailing.lessThanOrEqualTo(amountLabel.snp.leading).offset(-12)
        }

        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(12)
            make.trailing.lessThanOrEqualTo(dateLabel.snp.leading).offset(-12)
        }

        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(16)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(4)
            make.trailing.equalTo(amountLabel)
        }
    }

    func configure(with viewModel: TransactionCellViewModel) {
        accessibilityIdentifier = "transaction.cell.\(viewModel.title)"
        titleLabel.text = viewModel.title
        categoryLabel.text = viewModel.category
        amountLabel.text = viewModel.amount
        dateLabel.text = viewModel.date

        switch viewModel.type {
        case .income:
            amountLabel.textColor = .systemGreen

        case .expense:
            amountLabel.textColor = .label
        }
    }
}
