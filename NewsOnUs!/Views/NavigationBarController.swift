//
//  NavigationBarController.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 19.09.2023.
//

import UIKit

class NavigationBarController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = #colorLiteral(red: 0.08454743773, green: 0.2466894388, blue: 0.3876488507, alpha: 1)
        
        navigationController?.navigationBar.tintColor = .white
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
        //navigationController?.navigationBar.isTranslucent = true
        //navigationController?.navigationBar.compactAppearance = apperance
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
}





  

