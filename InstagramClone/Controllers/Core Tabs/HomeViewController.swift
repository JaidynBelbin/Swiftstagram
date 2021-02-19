//
//  ViewController.swift
//  InstagramClone
//
//  Created by Jaidyn Belbin on 19/2/21.
//
import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Checking authentication status
        handleNotAuthenticated()
        
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

