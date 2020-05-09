//
//  MUser.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 09.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import FirebaseFirestore

struct MUser {
    var name: String
    var secondName: String
    var city: String
    var address: String
    var avatarStringURL: String
    var email: String
    var id: String
    
    var representation: [String: Any] {
        var rep = ["name": name]
        rep["avatarStringURL"] = avatarStringURL
        rep["uid"] = id
        rep["email"] = email
        rep["secondName"] = secondName
        rep["city"] = city
        rep["address"] = address
        return rep
    }
    
    init(name: String, secondName: String, city: String, address: String, avatarStringURL: String, email: String, id: String) {
        self.name = name
        self.secondName = secondName
        self.city = city
        self.address = address
        self.avatarStringURL = avatarStringURL
        self.email = email
        self.id = id
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil }
        guard let name = data["username"] as? String,
            let secondName = data["secondName"] as? String,
            let city = data["city"] as? String,
            let address = data["address"] as? String,
            let avatarStringURL = data["avatarStringURL"] as? String,
            let uid = data["uid"] as? String,
            let email = data["email"] as? String
            else { return nil }
        
        self.name = name
        self.secondName = secondName
        self.city = city
        self.address = address
        self.avatarStringURL = avatarStringURL
        self.id = uid
        self.email = email        
    }
}
