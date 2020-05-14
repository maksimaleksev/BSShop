//
//  NetworkService.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 12.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
}

