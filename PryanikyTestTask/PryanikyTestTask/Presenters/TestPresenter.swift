//
//  TestPresenter.swift
//  PryanikyTestTask
//
//  Created by Melalujka on 01.10.2020.
//  Copyright © 2020 Melalujka. All rights reserved.
//

import Foundation

import UIKit

protocol Presenter {
    var source: [InfoType] { get }
    func viewReady()
}

enum InfoType {
    case text(name: String, title: String)
    case picture(name: String, title: String, url: String)
    case selector(name: String, id: Int, variant: [Variant])
}

final class TestPresenter: Presenter {
    
    weak var view: TestView?
    let network: NetworkService?
    private var types: [Element] = [] // types to present
    private var blocks: [String] = [] // blocks of types to present
    private var privateSource: [InfoType] {
        blocks.compactMap { [weak self] name -> InfoType? in
            self?.getCellInfo(name)
        }
    }
    var source: [InfoType] = []
    
    init(view: TestView, network: NetworkService) {
        self.view = view
        self.network = network
        view.presenter = self
    }
    
    func viewReady() {
        dataRequest()
    }
    
    private func dataRequest() {
        guard let url = URL(string: Constants.ServerConfig.url) else { return }
        network?.fetchData(url: url) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.updateData(data)
            case .failure(let error):
                print("Log Error: \(error.localizedDescription)")
                self?.view?.showErrorAlert(error.localizedDescription)
            }
        }
    }
    
    private func updateData(_ data: DataJSON) {
        types = data.data ?? []
        blocks = data.view ?? []
        source = privateSource
        view?.update()
    }
    
    private func getCellInfo(_ name: String) -> InfoType? {
        guard let cellData = types.first(where: { $0.name == name })?.data else { return nil }
        
        if let url = cellData.url {
            return .picture(name: name, title: cellData.text ?? "", url: url)
        }
        if let id = cellData.selectedId,
           let variants = cellData.variants {
            return .selector(name: name, id: id, variant: variants)
        }
        return .text(name: name, title: cellData.text ?? "")
    }
}
