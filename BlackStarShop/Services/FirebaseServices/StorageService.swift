//
//  StorageService.swift
//  
//
//  Created by Maxim Alekseev on 09.05.2020.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class StorageService {
    
    static let shared = StorageService()
    
    let storageRef = Storage.storage().reference()
    private var avatarRef: StorageReference {
        return storageRef.child("avatars")
    }
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    func upload(photo: UIImage, completion: @escaping ((Result<URL, Error>) -> Void)) {
        
        guard let scaledImage = photo.scaledToSafeUploadSize, let imageData = scaledImage.jpegData(compressionQuality: 0.4) else { return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        avatarRef.child(currentUserId).putData(imageData, metadata: metadata) { [weak self] (metadata, error) in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            
            if let self = self {
                self.avatarRef.child(self.currentUserId).downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        completion(.failure(error!))
                        return
                    }
                    completion(.success(downloadURL))
                }
            }
        }
    }
    
    func downloadImage(url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        let ref = Storage.storage().reference(forURL: url.absoluteString)
        let megaByte = Int64(1 * 1024 * 1024)
        ref.getData(maxSize: megaByte) { (data, error) in
            guard let imageData = data else {
                completion(.failure(error!))
                return
            }
            completion(.success(UIImage(data: imageData)!))
        }
    }
    
}
