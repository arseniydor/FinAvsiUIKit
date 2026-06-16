//
//  LoadingView.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import SnapKit
import UIKit

final class LoadingView: UIView {
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        nil
    }

    func start() {
        isHidden = false
        activityIndicator.startAnimating()
    }

    func stop() {
        activityIndicator.stopAnimating()
        isHidden = true
    }
}

private extension LoadingView {
    func setupViews() {
        backgroundColor = .systemBackground
        addSubview(activityIndicator)
    }

    func setupConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
