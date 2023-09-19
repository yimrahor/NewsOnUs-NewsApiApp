//
//  RegisterViewController.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 9.09.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var headTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Selectors
    @IBAction func didTapSignUp(_ sender: Any) {
        let registerUserRequest = RegisterUserRequest(username: self.usernameField.text ?? "", email: self.emailField.text ?? "", password: self.passwordField.text ?? "")
        
        // Username check
        if !Validator.isValidUsername(for: registerUserRequest.username) {
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }
        
        // Email check
        if !Validator.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        // Password check
        if !Validator.isPasswordValid(for: registerUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        print(registerUserRequest)
        
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else { return }
            
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
            
            if wasRegistered {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            } else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
    }
    
    
    @IBAction func didTapSignIn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true)
        }
    }
    
}
