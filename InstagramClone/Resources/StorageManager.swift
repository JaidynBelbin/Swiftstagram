//
//  StorageManager.swift
//  InstagramClone
//
//  Created by Jaidyn Belbin on 19/2/21.
//

import FirebaseStorage

public class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
   
    // MARK: Public
    
    public enum IGStorageManagerError: Error {
        
        // Custom error message
        case failedToDownload
    }
    
    // Want to be able to upload multiple kinds of things, so need a generic model for the UserPost
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, IGStorageManagerError>) -> Void) {
        
        bucket.child(reference).downloadURL { (url, error) in
            
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            
            // Do something with the URL
            completion(.success(url))
            
        }
    }
    
}

// Types of the user post
public enum UserPostType {
    case photo, video
}

public struct UserPost {
    let postType: UserPostType
}
