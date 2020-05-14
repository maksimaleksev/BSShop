//
//  ProductCollectionViewCellDelegate.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 14.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import Foundation

protocol ProductCollectionViewCellDelegate {
    func didTapBuyButton (shoppingProduct: ShoppingProductsResponse)
}
