//
//  ShopingCategoriesResponse.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 12.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import Foundation

struct ShopingCategoriesResponse: Decodable {
//    var shoes: ShoppingCategory?                  //---under construction uncomment this when it wil be ready
    var accessories: ShoppingCategory?
    var forWomen: ShoppingCategory?
    var forMen: ShoppingCategory?
    var forKids: ShoppingCategory?
    var collections: ShoppingCategory?
//    var preOrder: ShoppingCategory?               //---under construction uncomment this when it wil be ready
    var discounts: ShoppingCategory?
    var newProducts: ShoppingCategory?
    
    
    var collectionsSubCategories: [ShoppingSubCategoties] {
        
        let categories = [accessories, forWomen, forMen, forKids, collections, discounts, newProducts]
        var collections = [ShoppingSubCategoties]()
        for category in categories {
            if let category = category, let categoryCollections = category.subcategories  {
                collections.append(contentsOf: categoryCollections.filter({ $0.type == "Collection"}))
            }
        }
        
        return collections
    }
    
    
    var shopingCategories: [ShoppingCategory?] {
        return [accessories, forWomen, forMen, forKids, collections, discounts, newProducts].sorted { (cat1, cat2) -> Bool in
            
            if let cat1 = cat1, let cat2 = cat2, let sortNumber1 = cat1.sortOrder, let sortNumber2 = cat2.sortOrder {
                return sortNumber1 < sortNumber2
            } else {
                return false
            }
        }
        
    }
    
    
    func collectionSorted() -> [ShoppingSubCategoties] {
        return collectionsSubCategories.sorted { (collection1, collection2) -> Bool in
            guard let sortNum1 = collection1.sortOrder, let sortNum2 = collection2.sortOrder else { return false}
            return sortNum1 < sortNum2
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case shoes = "308"
        case accessories = "67"
        case forWomen = "68"
        case forMen = "69"
        case forKids = "73"
        case collections = "74"
        case preOrder = "123"
        case discounts = "156"
        case newProducts = "165"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.shoes = try? container.decode(ShoppingCategory.self, forKey: .shoes) //---under construction uncomment this when it wil be ready
        self.accessories = try? container.decode(ShoppingCategory.self, forKey: .accessories)
        self.forWomen = try? container.decode(ShoppingCategory.self, forKey: .forWomen)
        self.forMen = try? container.decode(ShoppingCategory.self, forKey: .forMen)
        self.forKids = try? container.decode(ShoppingCategory.self, forKey: .forKids)
        self.collections = try? container.decode(ShoppingCategory.self, forKey: .collections)
//        self.preOrder = try? container.decode(ShoppingCategory.self, forKey: .preOrder)   //---under construction uncomment this when it wil be ready
        self.discounts = try? container.decode(ShoppingCategory.self, forKey: .discounts)
        self.newProducts = try? container.decode(ShoppingCategory.self, forKey: .newProducts)
    }
    
}


struct ShoppingCategory: Decodable {
    var name: String?
    var sortOrder: Int?
    var image: String?
    var iconImage: String?
    var subcategories: [ShoppingSubCategoties]?
    
    var sortedSubCategories: [ShoppingSubCategoties] {
        guard let subcategories = subcategories else {return []}
        return subcategories.sorted { (subCat1, subCat2) -> Bool in
            guard let numSubCat1 = subCat1.sortOrder, let numSubCat2 = subCat2.sortOrder else { return false }
            return numSubCat1 < numSubCat2
        }
    }
        
        func categoryFiltered() -> [ShoppingSubCategoties] {
            return sortedSubCategories.filter { (shoppingSubCategory) -> Bool in
                guard let type = shoppingSubCategory.type, type == "Category" else { return false }
                return true
            }
        }
    
    enum CodingKeys: String, CodingKey {
        case name
        case sortOrder
        case image
        case iconImage
        case subcategories
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let sortOrder = try? container.decode(String.self, forKey: .sortOrder)
        self.name = try? container.decode(String.self, forKey: .name)
        self.sortOrder = Int(sortOrder ?? "")
        self.image = try? container.decode(String.self, forKey: .image)
        self.iconImage = try? container.decode(String.self, forKey: .iconImage)
        self.subcategories = try? container.decode([ShoppingSubCategoties].self, forKey: .subcategories)
    }
}

struct ShoppingSubCategoties: Decodable {
    var id: String?
    var iconImage: String?
    var sortOrder: Int?
    var name: String?
    var type: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case iconImage
        case sortOrder
        case name
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(String.self, forKey: .id)
        self.iconImage = try? container.decode(String.self, forKey: .iconImage)
        let sortOrder = try? container.decode(String.self, forKey: .sortOrder)
        self.sortOrder = Int(sortOrder ?? "")
        self.name = try? container.decode(String.self, forKey: .name)
        self.type = try? container.decode(String.self, forKey: .type)
    }
}
