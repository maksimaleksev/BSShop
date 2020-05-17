//
//  PersistantDataService.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 16.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import Foundation

import RealmSwift

class RealmDataService {
    
    static let shared = RealmDataService()
    private let realm = try! Realm()
    
    func saveObject(object: CartModel) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    func delObject(object: CartModel) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func delAllObjects() {
        let objectsToDelete = realm.objects(CartModel.self)
        try! realm.write {
            objectsToDelete.forEach { realm.delete($0) }
        }
    }
    
    func loadObjects() -> Results<CartModel> {
        return realm.objects(CartModel.self)
    }
}
