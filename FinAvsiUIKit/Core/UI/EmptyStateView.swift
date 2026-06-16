//
//  EmptyStateView.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import SnapKit
import UIKit

final class EmptyStateView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        nil
    }

    func configure(image: UIImage?, title: String, subtitle: String) {
        imageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}

private extension EmptyStateView {
    func setupViews() {
        let stack = UIStackView(
            arrangedSubviews: [
                imageView,
                titleLabel,
                subtitleLabel,
            ]
        )

        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center

        addSubview(stack)

        stack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }

    func setupConstraints() {}
}
