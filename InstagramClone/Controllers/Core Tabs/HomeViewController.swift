//
//  ViewController.swift
//  InstagramClone
//
//  Created by Jaidyn Belbin on 19/2/21.
//
import FirebaseAuth
import UIKit

var handle: AuthStateDidChangeListenerHandle?

class HomeViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Checking authentication status
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if let user = user {
                
                if let name = user.displayName {
                    self.navigationItem.title = "Welcome \(name)!"
                } else {
                    self.navigationItem.title = "\(user.uid)"
                }
                
            } else {
                
                let loginVC = LoginViewController()
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: false)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
        //handleNotAuthenticated()
        
       
    }
    
    private func handleNotAuthenticated() {
        
        if Auth.auth().currentUser == nil {
            
            // Show login view
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
}

