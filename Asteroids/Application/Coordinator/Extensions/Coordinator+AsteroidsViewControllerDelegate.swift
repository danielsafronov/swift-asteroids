//
//  Coordinator+AsteroidsViewControllerDelegate.swift
//  Asteroids
//
//  Created by Daniel Safronov on 27.05.2022.
//

import Foundation

extension Coordinator: AsteroidsViewControllerDelegate {
    /// Tells the delegate that the asteroid did selected.
    /// - parameter asteroidId: The selected asteroid identifier.
    func didSelectAsteroid(asteroidId: Int) {
        coordinateToAsteroid(arguments: .init(asteroidId: asteroidId))
    }
}
