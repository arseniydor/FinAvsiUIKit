//
//  DashboardButtonCell.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import SnapKit
import UIKit

protocol DashboardButtonCellDelegate: AnyObject {
    func didTapDashboardButtonCell()
}

final class DashboardButtonCell: BaseTableViewCell {
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        return button
    }()

    public weak var delegate: DashboardButtonCellDelegate?

    override func setupViews() {
        selectionStyle = .none
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        contentView.addSubview(button)
    }

    override func setupConstraints() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
    }

    func configure(title: String) {
        button.setTitle(title, for: .normal)
    }

    @objc
    private func buttonTapped() {
        delegate?.didTapDashboardButtonCell()
    }
}
