//
//  DashboardEmptyCategoryCell.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import SnapKit
import UIKit

final class DashboardEmptyCategoryCell: BaseTableViewCell {
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        return label
    }()

    override func setupViews() {
        selectionStyle = .none
        contentView.addSubview(emptyLabel)
    }

    override func setupConstraints() {
        emptyLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }

    func configure(text: String) {
        emptyLabel.text = text
    }
}
