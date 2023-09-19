//
//  SceneDelegate.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 5.09.2023.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        //self.setupWindow(with: scene)
        self.checkAuthentication()
        
        let screenMode = UserDefaults.standard.bool(forKey: "darkMode")
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let appDelegate = windowScene.windows.first {
            if screenMode  {
                appDelegate.overrideUserInterfaceStyle = .dark
            } else {
                appDelegate.overrideUserInterfaceStyle = .light
            }
            
        }
    }
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    public func checkAuthentication() {
        let currentUser = Auth.auth().currentUser
        if currentUser == nil {
            let board =  UIStoryboard(name: "Main", bundle: nil)
            let vc = board.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
            window?.rootViewController = vc
        } else {
            let board =  UIStoryboard(name: "TabBar", bundle: nil)
            let vc = board.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
            window?.rootViewController = vc
        }
    }
        
        func sceneDidDisconnect(_ scene: UIScene) {
            // Called as the scene is being released by the system.
            // This occurs shortly after the scene enters the background, or when its session is discarded.
            // Release any resources associated with this scene that can be re-created the next time the scene connects.
            // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        }
        
        func sceneDidBecomeActive(_ scene: UIScene) {
            // Called when the scene has moved from an inactive state to an active state.
            // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        }
        
        func sceneWillResignActive(_ scene: UIScene) {
            // Called when the scene will move from an active state to an inactive state.
            // This may occur due to temporary interruptions (ex. an incoming phone call).
        }
        
        func sceneWillEnterForeground(_ scene: UIScene) {
            // Called as the scene transitions from the background to the foreground.
            // Use this method to undo the changes made on entering the background.
        }
        
        func sceneDidEnterBackground(_ scene: UIScene) {
            // Called as the scene transitions from the foreground to the background.
            // Use this method to save data, release shared resources, and store enough scene-specific state information
            // to restore the scene back to its current state.
        }
        
        
}
    
    
