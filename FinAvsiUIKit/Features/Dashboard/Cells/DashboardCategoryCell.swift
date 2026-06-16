//
//  DashboardCategoryCell.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import SnapKit
import UIKit

final class DashboardCategoryCell: BaseTableViewCell {
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()

    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .right
        return label
    }()

    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel
        return label
    }()

    override func setupViews() {
        selectionStyle = .none
        contentView.addSubview(categoryLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(countLabel)
    }

    override func setupConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
            make.trailing.lessThanOrEqualTo(amountLabel.snp.leading).offset(-12)
        }

        amountLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(12)
        }

        countLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalToSuperview().inset(12)
        }
    }

    func configure(with viewModel: CategoryAnalyticsViewModel) {
        categoryLabel.text = viewModel.category
        amountLabel.text = viewModel.amountText
        countLabel.text = "\(viewModel.transactionCountText) transactions"
    }
}
