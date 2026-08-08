//
//  SceneDelegate.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let contentView = ContentView()
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
}

