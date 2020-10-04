//
//  TestViewController.swift
//  PryanikyTestTask
//
//  Created by Melalujka on 01.10.2020.
//  Copyright © 2020 Melalujka. All rights reserved.
//

import UIKit

protocol TestView: class {
    var presenter: Presenter? { get set }
    func setup(with presenter: TestPresenter, data: [String])
    func showErrorAlert(_ message: String)
    func update()
}

final class TestViewController: UIViewController, TestView {
    
    var presenter: Presenter?
    private var tableView: UITableView?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    func setup(with presenter: TestPresenter, data: [String]) {
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAndConfigureTableView()
        presenter?.viewReady()
    }
    
    func showErrorAlert(_ message: String) {
        showSimpleAlertView(message: message)
    }
    
    func update() {
        tableView?.reloadData()
    }
    
    private func setupAndConfigureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView!)
        
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(TestTextTableViewCell.self, forCellReuseIdentifier: TestTextTableViewCell.identifier)
        tableView?.register(TestPictureTableViewCell.self, forCellReuseIdentifier: TestPictureTableViewCell.identifier)
        tableView?.register(TestSelectorTableViewCell.self, forCellReuseIdentifier: TestSelectorTableViewCell.identifier)
    }
}

extension TestViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.source.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = presenter?.source[indexPath.row] else { return UITableViewCell() }
        var cell: TestTableViewCell?
        switch item {
        case .text:
            cell = tableView.dequeueReusableCell(withIdentifier: TestTextTableViewCell.identifier) as? TestTableViewCell
        case .picture:
            cell = tableView.dequeueReusableCell(withIdentifier: TestPictureTableViewCell.identifier) as? TestTableViewCell
        case .selector:
            cell = tableView.dequeueReusableCell(withIdentifier: TestSelectorTableViewCell.identifier) as? TestTableViewCell
        }
        cell?.configure(item)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? TestTableViewCell
        showSimpleAlertView(message: cell?.name ?? "")
    }
}
