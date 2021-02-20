//
//  AuthManager.swift
//  InstagramClone
//
//  Created by Jaidyn Belbin on 19/2/21.
//

import FirebaseAuth

public class AuthManager {
    
    // Creating a globally accessable instance of this class
    static let shared = AuthManager()
    
    // MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        // Check if username and email are available, DEFAULTS TO TRUE
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                
                // Creating the user in Firebase
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    
                    guard error == nil, result != nil else {
                        
                        // Firebase auth could not create account
                        completion(false)
                        return
                    }
                    
                    // Giving the user a display name when they sign up
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    
                    changeRequest?.displayName = username
                    changeRequest?.commitChanges(completion: { error in
                        
                        guard error == nil else {
                            
                            completion(false)
                            return
                        }
                    })
                    
                    // Insert the newly created user into the database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            
                            // Successfully inserted
                            completion(true)
                            return
                            
                        } else {
                            
                            // Failed to insert
                            completion(false)
                            return
                        }
                    }
                }
                
            } else {
                completion(false)
            }
        }
    }

    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        
        if let email = email {
            
            // Signing in with Firebase using email (note the closure expression { blah blah blah } )
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                
                guard authResult != nil, error == nil else {
                    
                    completion(false)
                    return
                }
                
                completion(true)
            }
                
            
            // email login
            
        } else if let username = username {
            
            // username login
            print(username)
            
        }
    }
    
    /// Attempt to log out Firebase user
    public func logOut(completion: (Bool) -> Void) {
        
        do {
            try Auth.auth().signOut()
            completion(true)
            return
            
        } catch {
            
            print(error)
            completion(false)
            return
        }
    }
}
