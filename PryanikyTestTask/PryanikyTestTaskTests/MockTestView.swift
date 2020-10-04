//
//  MockTestView.swift
//  PryanikyTestTask
//
//  Created by Melalujka on 04.10.2020.
//  Copyright © 2020 Melalujka. All rights reserved.
//

@testable import PryanikyTestTask

class MockTestView: TestView {
    
    var presenter: Presenter?
    
    func setup(with presenter: TestPresenter, data: [String]) {}
    
    func showErrorAlert(_ message: String) {}
    
    func update() {}
}
