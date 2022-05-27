//
//  Coordinator.swift
//  Asteroids
//
//  Created by Daniel Safronov on 27.05.2022.
//

import Foundation
import UIKit

/// Coordinator class.
final class Coordinator {
    /// An instance of `UINavigationController`.
    private let controller: UINavigationController
    
    /// Creates a new instance of `Coordinator`.
    /// - parameter controller: An instance of `UINavigationController`.
    /// - returns: An instance of `Coordinator`.
    init(controller: UINavigationController) {
        self.controller = controller
    }
    
    /// Starts coordinator flow.
    func start() {
        coordinateToAsteroids()
    }
    
    /// Coordinates to asteroids.
    func coordinateToAsteroids() {
        let controller = AsteroidsViewController()
        controller.delegate = self
        
        self.controller.pushViewController(controller, animated: false)
    }
    
    /// Coordinates to asteroid.
    /// - parameter arguments: An instance of `AsteroidViewController.Arguments`.
    func coordinateToAsteroid(arguments: AsteroidViewController.Arguments) {
        let controller = AsteroidViewController(arguments: arguments)
        self.controller.pushViewController(controller, animated: false)
    }
}
