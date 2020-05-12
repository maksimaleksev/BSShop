//
//  NetworkDataFetcher.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 12.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
    
    static let shared = NetworkDataFetcher()
    
    func fetchCategories(response: @escaping (ShopingCategoriesResponse?) -> Void) {
        let urlString = "https://blackstarshop.ru/index.php?route=api/v1/categories"
        NetworkService.shared.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let categories = try JSONDecoder().decode(ShopingCategoriesResponse.self, from: data)
                    response(categories)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
}
