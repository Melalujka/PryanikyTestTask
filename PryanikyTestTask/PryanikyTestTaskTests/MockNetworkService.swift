//
//  MockNetworkService.swift
//  PryanikyTestTask
//
//  Created by Melalujka on 04.10.2020.
//  Copyright © 2020 Melalujka. All rights reserved.
//

import Foundation
@testable import PryanikyTestTask

class MockNetworkService: NetworkService {
    
    func fetchData(url: URL, completion: @escaping (Result<DataJSON, ResponseError>) -> ()) {
        guard let path = Bundle(for: type(of: self)).path(forResource: "MockData", ofType: "json"),
            let data = try? NSData(contentsOfFile: path) as Data,
            let result = try? JSONDecoder().decode(DataJSON.self, from: data) else {
                fatalError("Test JSON file missed or corrupted")
        }
        
        completion(.success(result))
    }
}
