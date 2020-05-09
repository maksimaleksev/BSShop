//
//  FireStoreService.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 09.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import Firebase
import FirebaseFirestore

class FirestoreService {
    
    static let shared = FirestoreService()
    
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    var currentUser: MUser!
    
    func saveProfileWith(id: String, email: String, name: String?, avatarImage: UIImage?, secondName: String?, city: String?, address: String?, completion: @escaping ((Result<MUser, Error>) -> Void)) {
        
        guard Validators.isFilled(name: name, secondName: secondName, city: city, address: address) else  {
            completion(.failure(UserError.notFilled))
            return
        }
        
        guard avatarImage != #imageLiteral(resourceName: "avatar") else {
            completion(.failure(UserError.photoNotExist))
            return
        }
        
        var mUser = MUser(name: name!,
                          secondName: secondName!,
                          city: city!,
                          address: address!,
                          avatarStringURL: "none",
                          email: email,
                          id: id)
        
        StorageService.shared.upload(photo: avatarImage!) { (result) in
            
            switch result {
                
            case .success(let url):
                mUser.avatarStringURL = url.absoluteString
                self.usersRef.document(mUser.id).setData(mUser.representation) { (error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(mUser))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        } // StorageService
        
    } //saveProfileWith
    
    func getUserData(user: User, completion: @escaping ((Result<MUser, Error>) -> Void)) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let muser = MUser(document: document) else {
                    completion(.failure(UserError.cannotUnwrapToMUser))
                    return
                }
                self.currentUser = muser
                completion(.success(muser))
            } else {
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }
    }
    
    
}

