//
//  BaseViewController.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import SnapKit
import UIKit

class BaseViewController: UIViewController {
    let contentView: UIView = {
        let view = UIView()
        return view
    }()

    let loadingView: LoadingView = {
        let view = LoadingView()
        return view
    }()

    let errorView: ErrorView = {
        let view = ErrorView()
        return view
    }()

    let emptyStateView: EmptyStateView = {
        let view = EmptyStateView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAppearance()
        setupViews()
        setupConstraints()

        hideLoading()
        hideError()
        hideEmptyState()
    }

    func configureAppearance() {
        view.backgroundColor = .systemBackground
    }

    func setupViews() {
        view.addSubview(contentView)
        view.addSubview(loadingView)
        view.addSubview(errorView)
        view.addSubview(emptyStateView)
    }

    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        loadingView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }

        errorView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }

        emptyStateView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }

    func retry() {
        showContent()
    }
}

extension BaseViewController {
    func showLoading() {
        contentView.isHidden = true
        errorView.isHidden = true
        emptyStateView.isHidden = true

        loadingView.start()
    }

    func hideLoading() {
        loadingView.stop()
    }

    func showError(title: String = "Something went wrong", message: String) {
        hideLoading()

        contentView.isHidden = true
        emptyStateView.isHidden = true

        errorView.configure(title: title, message: message)
        errorView.delegate = self
        errorView.isHidden = false
    }

    func hideError() {
        errorView.isHidden = true
    }

    func showEmptyState(image: UIImage? = UIImage(systemName: "tray"), title: String, subtitle: String) {
        hideLoading()

        contentView.isHidden = true
        errorView.isHidden = true

        emptyStateView.configure(
            image: image,
            title: title,
            subtitle: subtitle
        )

        emptyStateView.isHidden = false
    }

    func hideEmptyState() {
        emptyStateView.isHidden = true
    }

    func showContent() {
        hideLoading()
        hideError()
        hideEmptyState()

        contentView.isHidden = false
    }
}

extension BaseViewController: ErrorViewDelegate {
    func didTapRetry() {
        retry()
    }
}
