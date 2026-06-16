//
//  BaseTableViewCell.swift
//  FinAvsiUIKit
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        nil
    }

    func setupViews() {}

    func setupConstraints() {}
}
