//
//  CartDataModel.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 16.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import RealmSwift

class CartModel: Object {
    @objc dynamic var productName: String = ""
    @objc dynamic var price: String = ""
    @objc dynamic var productSize: String = ""
    @objc dynamic var productColor: String = ""
    @objc dynamic var productImage: String? = ""
    
    convenience init(productName: String, price: String, productSize:  String, productColor: String, productImage: String?) {
        self.init()
        self.productName = productName
        self.price = price
        self.productSize = productSize
        self.productColor = productColor
        self.productImage = productImage
    }
}
