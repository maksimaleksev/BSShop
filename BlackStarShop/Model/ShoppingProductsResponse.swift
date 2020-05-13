//
//  ShoppingProductsResponse.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 13.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import Foundation

struct ShoppingProductsResponse: Decodable {
    var name: String
    var sortOrder: String?
    var description: String?
    var mainImage: String?
    var productImages: [ShoppingProductsImages]
    var offers: [ShoppingProductsOffer]
    var price: String?
}


struct ShoppingProductsImages: Decodable {
    var imageURL: String?
    var sortOrder: String?
}

struct ShoppingProductsOffer: Decodable {
    var size: String
}
