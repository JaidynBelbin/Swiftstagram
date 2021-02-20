//
//  DatabaseManager.swift
//  InstagramClone
//
//  Created by Jaidyn Belbin on 19/2/21.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    // MARK: Public
    
    
    /// Check if username and email is available
    /// - Parameters
    ///     - email: String representing the email
    ///     - username: String representing username
    public func canCreateNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        
        completion(true)
    }
    
    /// Inserts new user to database
    /// - Parameters
    ///     - email: String representing the email
    ///     - username: String representing username
    ///     - completion: Async callback for result if database entry successful
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            
            if error == nil {
                
                completion(true)
                return
            } else {
                
                completion(false)
                return
            }
        }
    }
}
