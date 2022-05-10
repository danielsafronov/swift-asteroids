//
//  SceneDelegate.swift
//  Asteroids
//
//  Created by Daniel Safronov on 03.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let rootViewController = AsteroidsViewController()
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
        
        self.window = window
    }
}

