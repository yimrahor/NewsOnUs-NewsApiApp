//
//  LoginViewController.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 9.09.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - UI Components
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var headTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    // MARK: - Selectors
    @IBAction private func didTapSignIn(_ sender: Any) {
        let loginRequest = LoginUserRequest(email: self.emailField.text ?? "", password: passwordField.text ?? "")
        
        // Email check
        if !Validator.isValidEmail(for: loginRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        // Password check
        if !Validator.isPasswordValid(for: loginRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.signIn(with: loginRequest) { error in
            if let error = error {
                AlertManager.showSignInErrorAlert(on: self, with: error)
                return
            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
        
    
    @IBAction private func didTapNewUser(_ sender: Any) {
        print("basıldı")
        let storyboard = UIStoryboard(name: "RegisterViewController", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true)
        }
    }
    

    @IBAction private func didTapForgotPassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ForgotPasswordViewController", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController {
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true)
        }
    }
}
