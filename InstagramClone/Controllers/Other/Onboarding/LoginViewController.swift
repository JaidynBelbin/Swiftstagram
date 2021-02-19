//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by Jaidyn Belbin on 19/2/21.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
//    Declaring all of the elements on our login screen programatically
    
    
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter username or email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        
        // Buffer on left side of text so not up against edge of input box
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    private let termsButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New user? Create an account", for: .normal)
        
        return button
    }()
   
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImageView)
        
        return header
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameEmailField.delegate = self
        passwordField.delegate = self
        
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        
        createAccountButton.addTarget(self,
                              action: #selector(didTapCreateAccountButton),
                              for: .touchUpInside)
        
        termsButton.addTarget(self,
                              action: #selector(didTapTermsButton),
                              for: .touchUpInside)
        
        privacyButton.addTarget(self,
                              action: #selector(didTapPrivacyButton),
                              for: .touchUpInside)
        
        addSubViews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Assign frames
        
        headerView.frame = CGRect(
            x: 0,
            y: 0.0,
            width: view.width,
            height: view.height/3.0)
        
        usernameEmailField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 20,
            width: view.width - 50,
            height: 52)
        
        passwordField.frame = CGRect(
            x: 25,
            y: usernameEmailField.bottom + 10,
            width: view.width - 50,
            height: 52)
        
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 25,
            width: view.width - 50,
            height: 52)
        
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.width - 50,
            height: 52)
        
        termsButton.frame = CGRect(
            x: view.right - 175,
            y: view.height - view.safeAreaInsets.bottom - 50,
            width: view.width - 225,
            height: 50)
        
        privacyButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 50,
            width: view.width - 225,
            height: 50)
        
        
        configureHeaderView()
}
    
    private func configureHeaderView() {
        
        // This is making sure the headerView initially only has one subview: the
        // image background, then we get that first (and only) subview, and set its
        // frame to be the bounds of the header, ie. making sure the image background
        // doesn't spill over the edges
        guard headerView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        
        backgroundView.frame = headerView.bounds
        
        // Now we add the text on top of the gradient background
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4.0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width/2.0,
                                 height: headerView.height - view.safeAreaInsets.top)
    }
    
    private func addSubViews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
        
    }
    
    @objc private func didTapLoginButton() {
        
        // Dismisses the keyboard
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        // Login functionality
        
        
    }
    
    // Showing the terms of service in a WebView
    @objc private func didTapTermsButton() {
        
        guard let url = URL(string: "https://www.facebook.com/help/instagram/termsofuse") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapPrivacyButton() {
        
        guard let url = URL(string: "https://www.facebook.com/help/instagram/519522125107875/?helpref=hc_fnav&bc[0]=Instagram%20Help&bc[1]=Privacy%20and%20Safety%20Center") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapCreateAccountButton() {
        
        let vc = RegistrationViewController()
        present(vc, animated: true)
        
    }
    
}

// Handling returns in the text fields
extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            
            // Passing focus to the password field
            passwordField.becomeFirstResponder()
            
        } else if textField == passwordField {
            
            // If we return in the password field, do the same thing as clicking the login button
            didTapLoginButton()
        }
        
        return true
    }
}
