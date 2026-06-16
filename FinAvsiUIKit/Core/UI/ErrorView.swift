//
//  ErrorView.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import SnapKit
import UIKit

protocol ErrorViewDelegate: AnyObject {
    func didTapRetry()
}

final class ErrorView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        return label
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()

    public weak var delegate: ErrorViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        nil
    }

    func configure(title: String = "Something went wrong", message: String, retryTitle: String = "Try Again") {
        titleLabel.text = title
        messageLabel.text = message
        retryButton.setTitle(retryTitle, for: .normal)
    }
}

private extension ErrorView {
    func setupViews() {
        backgroundColor = .systemBackground

        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)

        let stackView = UIStackView(
            arrangedSubviews: [
                titleLabel,
                messageLabel,
                retryButton,
            ]
        )

        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .center

        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }

    func setupConstraints() {}

    @objc
    func retryButtonTapped() {
        delegate?.didTapRetry()
    }
}
