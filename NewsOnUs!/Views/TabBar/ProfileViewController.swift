//
//  ProfileViewController.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 9.09.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var darkModeLbl: UILabel!
    @IBOutlet weak var switchTheme: UISwitch!
    @IBOutlet weak var agePickerView: UIPickerView!
    
    var ages = ["0-18", "18-30", "30-45", "45-60", "60-100"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        agePickerView.isHidden = true
        
        if #available(iOS 13.0, *) {
            let darkMode = UserDefaults.standard.bool(forKey: "darkMode")
            switchTheme.isOn = darkMode
        }
        
        
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }
            if let user = user {
                self.nameText.text = " \(user.username)"
                self.emailText.text = " \(user.email)"
            }
        }
        
        configurePicker()
        ageText.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ageTextTapped))
        ageText.addGestureRecognizer(tapGesture)
    }
    

    func configurePicker() {
        agePickerView.delegate = self
        agePickerView.dataSource = self
    }
    
    @objc func ageTextTapped(sender: UITapGestureRecognizer) {
        agePickerView.isHidden = false
        if sender.state == .ended {
            print("Texte tıklandı!")
        }
    }

    
    @IBAction func didTapLogout(_ sender: Any) {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
    
    
    @IBAction func switchThemeValueChanged(_ sender: UISwitch) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let appDelegate = windowScene.windows.first {
            UserDefaults.standard.set(sender.isOn, forKey: "darkMode")
            if sender.isOn {
                appDelegate.overrideUserInterfaceStyle = .dark
            } else {
                appDelegate.overrideUserInterfaceStyle = .light
            }
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let appDelegate = windowScene.windows.first {
                UserDefaults.standard.set(sender.isOn, forKey: "darkMode")
                if sender.isOn {
                    appDelegate.overrideUserInterfaceStyle = .dark
                } else {
                    appDelegate.overrideUserInterfaceStyle = .light
                }
                
            }
        }
    }
    
}



//MARK: UIPickerView
extension ProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ageText.text = "\(ages[row])"
        agePickerView.isHidden = true
    }
      
}
