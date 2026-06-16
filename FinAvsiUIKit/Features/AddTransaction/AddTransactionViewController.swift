//
//  AddTransactionViewController.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 16/06/2026.
//

import SnapKit
import UIKit

final class AddTransactionViewController: BaseViewController {
    private let viewModel: AddTransactionViewModel

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .interactive
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 12
        textField.clearButtonMode = .whileEditing
        textField.leftView = UIView(
            frame: CGRect(x: 0, y: 0, width: 12, height: 0)
        )
        textField.leftViewMode = .always
        return textField
    }()

    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Amount"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 12
        textField.clearButtonMode = .whileEditing
        textField.leftView = UIView(
            frame: CGRect(x: 0, y: 0, width: 12, height: 0)
        )
        textField.leftViewMode = .always
        textField.keyboardType = .decimalPad
        return textField
    }()

    private let categoryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Category"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 12
        textField.clearButtonMode = .whileEditing
        textField.leftView = UIView(
            frame: CGRect(x: 0, y: 0, width: 12, height: 0)
        )
        textField.leftViewMode = .always
        return textField
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 12
        textView.textContainerInset = UIEdgeInsets(
            top: 12,
            left: 8,
            bottom: 12,
            right: 8
        )
        return textView
    }()

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        return datePicker
    }()

    private let typeSegmentedControl = UISegmentedControl(items: TransactionType.allCases.map { $0.rawValue })

    private let paymentMethodSegmentedControl = UISegmentedControl(items: PaymentMethod.allCases.map { $0.rawValue })

    init(viewModel: AddTransactionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureAppearance() {
        super.configureAppearance()

        title = "Add Transaction"

        navigationItem.largeTitleDisplayMode = .never

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonTapped)
        )

        let saveBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveButtonTapped)
        )
        saveBarButtonItem.accessibilityIdentifier = "addTransaction.saveButton"
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }

    override func setupViews() {
        super.setupViews()

        configureSegments()

        contentView.addSubview(scrollView)
        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(makeSectionTitle("Main Info"))
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(amountTextField)
        stackView.addArrangedSubview(categoryTextField)

        stackView.addArrangedSubview(makeSectionTitle("Type"))
        stackView.addArrangedSubview(typeSegmentedControl)

        stackView.addArrangedSubview(makeSectionTitle("Payment Method"))
        stackView.addArrangedSubview(paymentMethodSegmentedControl)

        stackView.addArrangedSubview(makeSectionTitle("Date"))
        stackView.addArrangedSubview(datePicker)

        stackView.addArrangedSubview(makeSectionTitle("Description"))
        stackView.addArrangedSubview(descriptionTextView)
        
        titleTextField.accessibilityIdentifier = "addTransaction.titleTextField"
        amountTextField.accessibilityIdentifier = "addTransaction.amountTextField"
        categoryTextField.accessibilityIdentifier = "addTransaction.categoryTextField"
        descriptionTextView.accessibilityIdentifier = "addTransaction.descriptionTextView"
        typeSegmentedControl.accessibilityIdentifier = "addTransaction.typeSegmentedControl"
        paymentMethodSegmentedControl.accessibilityIdentifier = "addTransaction.paymentMethodSegmentedControl"
        datePicker.accessibilityIdentifier = "addTransaction.datePicker"
    }

    override func setupConstraints() {
        super.setupConstraints()

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide).inset(16)
            make.width.equalTo(scrollView.frameLayoutGuide).offset(-32)
        }

        titleTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }

        amountTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }

        categoryTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }

        descriptionTextView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
    }

    private func configureSegments() {
        typeSegmentedControl.selectedSegmentIndex = 1
        paymentMethodSegmentedControl.selectedSegmentIndex = 0
    }

    private func makeSectionTitle(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        return label
    }

    @objc
    private func cancelButtonTapped() {
        viewModel.cancelButtonTapped()
    }

    @objc
    private func saveButtonTapped() {
        guard let title = titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !title.isEmpty else {
            showError(message: "Please enter transaction title.")
            return
        }

        guard let amountText = amountTextField.text?.replacingOccurrences(of: ",", with: "."), let amount = Double(amountText), amount > 0 else {
            showError(message: "Please enter valid amount.")
            return
        }

        guard let category = categoryTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !category.isEmpty else {
            showError(message: "Please enter category.")
            return
        }

        let type = TransactionType.allCases[typeSegmentedControl.selectedSegmentIndex]

        let paymentMethod = PaymentMethod.allCases[paymentMethodSegmentedControl.selectedSegmentIndex]

        let description = descriptionTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)

        viewModel.saveButtonTapped(
            title: title,
            amount: amount,
            type: type,
            category: category,
            description: description.isEmpty ? nil : description,
            paymentMethod: paymentMethod,
            date: datePicker.date
        )
    }
}

extension AddTransactionViewController: AddTransactionViewModelDelegate {
    func addTransactionViewModelDidSave(_ viewModel: AddTransactionViewModel) { }

    func addTransactionViewModel(_ viewModel: AddTransactionViewModel, didFailWith message: String) {
        showError(message: message)
    }
}
