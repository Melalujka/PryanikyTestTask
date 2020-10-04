//
//  TestSelectorTableViewCell.swift
//  PryanikyTestTask
//
//  Created by Melalujka on 01.10.2020.
//  Copyright © 2020 Melalujka. All rights reserved.
//

import UIKit

class TestSelectorTableViewCell: UITableViewCell, TestTableViewCell {
    
    var name: String?
    var selector: [Variant]?
    var selectorId: Int?
    lazy var picker: UIPickerView = UIPickerView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        picker.dataSource = self as UIPickerViewDataSource
        picker.delegate = self as UIPickerViewDelegate
        
        addSubview(picker)
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        picker.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        picker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        picker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    }
    
    func configure(_ data: InfoType) {
        guard case .selector(name: let name, id: let id, variant: let variants) = data else { return }
        self.name = name
        selectorId = id
        selector = variants
        picker.selectRow(selectorId ?? 0, inComponent: 0, animated: false)
        
    }
}

extension TestSelectorTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selector?.count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = selector?[row].text
        return row
    }
}
