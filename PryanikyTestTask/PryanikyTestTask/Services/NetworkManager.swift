//
//  NetworkManager.swift
//  PryanikyTestTask
//
//  Created by Melalujka on 01.10.2020.
//  Copyright © 2020 Melalujka. All rights reserved.
//

import UIKit

protocol NetworkService {
    func fetchData(url: URL, completion: @escaping (Result<DataJSON, ResponseError>)->())
}

protocol ImageLoader {
    func downloadPicture(url: URL, completion: @escaping (UIImage?)->())
    func cancel()
}

enum ResponseError: Error {
    case internetError, decodeError
}

class NetworkManager: NetworkService {
    
    private var task: URLSessionDataTask?
    
    func fetchData(url: URL, completion: @escaping (Result<DataJSON, ResponseError>)->()) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.internetError))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(DataJSON.self, from: data)
                print(result)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(.failure(.decodeError))
                }
            }
        }.resume()
    }
}

extension NetworkManager: ImageLoader {
    
    func downloadPicture(url: URL, completion: @escaping (UIImage?)->()) {
        task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}
