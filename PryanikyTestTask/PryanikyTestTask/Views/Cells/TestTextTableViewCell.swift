//
//  TestTextTableViewCell.swift
//  PryanikyTestTask
//
//  Created by Melalujka on 01.10.2020.
//  Copyright © 2020 Melalujka. All rights reserved.
//

import UIKit

protocol TestTableViewCell: UITableViewCell {
    func configure(_ data: InfoType)
}

class TestTextTableViewCell: UITableViewCell, TestTableViewCell {
    
    lazy var textInfo: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(textInfo)
        textInfo.translatesAutoresizingMaskIntoConstraints = false
        textInfo.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        textInfo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        textInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        textInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    }

    func configure(_ data: InfoType) {
        guard case .text(title: let title) = data else { return }
        textInfo.text = title
    }
    
    override func prepareForReuse() {
        textInfo.text = ""
    }
}
