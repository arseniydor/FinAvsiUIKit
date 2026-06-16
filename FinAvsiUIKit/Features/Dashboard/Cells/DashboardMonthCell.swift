//
//  DashboardMonthCell.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import SnapKit
import UIKit

protocol DashboardMonthCellDelegate: AnyObject {
    func previousAction()
    func nextAction()
}

final class DashboardMonthCell: BaseTableViewCell {
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()

    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()

    private let monthLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        return label
    }()

    public weak var delegate: DashboardMonthCellDelegate?

    func configure(monthTitle: String) {
        monthLabel.text = monthTitle
    }

    override func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        previousButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        nextButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        contentView.addSubview(previousButton)
        contentView.addSubview(monthLabel)
        contentView.addSubview(nextButton)
    }

    override func setupConstraints() {
        previousButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(36)
        }

        nextButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(36)
        }

        monthLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.greaterThanOrEqualTo(previousButton.snp.trailing).offset(12)
            make.trailing.lessThanOrEqualTo(nextButton.snp.leading).offset(-12)
            make.top.bottom.equalToSuperview().inset(12)
        }
    }

    @objc
    private func previousButtonTapped() {
        delegate?.previousAction()
    }

    @objc
    private func nextButtonTapped() {
        delegate?.nextAction()
    }
}
