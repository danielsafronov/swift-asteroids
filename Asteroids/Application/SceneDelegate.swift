//
//  SceneDelegate.swift
//  Asteroids
//
//  Created by Daniel Safronov on 03.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    /// An instance of `UIWindow` or `nil`.
    var window: UIWindow?
    
    /// An instance of `Coordinator` or `nil`.
    var coordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let navigationViewController = UINavigationController()
        let coordinator = Coordinator(controller: navigationViewController)
        coordinator.start()
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
        
        self.window = window
        self.coordinator = coordinator
    }
}
