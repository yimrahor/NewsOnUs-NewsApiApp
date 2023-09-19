//
//  ForgotPasswordViewController.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 9.09.2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var headTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var emailField: UITextField!
    

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    
    
    // MARK: - Selectors
    @IBAction func didTapForgotPassword(_ sender: Any) {
        let email = self.emailField.text ?? ""
        
        if !Validator.isValidEmail(for: email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
                return
            }
            AlertManager.showPasswordResetSent(on: self)
        }
    }
    
    @IBAction func didTapSignIn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
}
