//
//  DefaultGetAsteroidUseCase.swift
//  Asteroids
//
//  Created by Daniel Safronov on 04.05.2022.
//

import Foundation

/// DefaultGetAsteroidUseCase structure.
struct DefaultGetAsteroidUseCase: GetAsteroidUseCase {
    /// An instance of `AsteroidRepository`.
    let repository: AsteroidRepository
    
    /// Returns an instance of `Asteroid` by specified identifier or `nil`.
    /// - parameter id: The identifier of the `Asteroid` instance.
    /// - returns: The result instance with instance of `Asteroid` if instance exists, `nil` if instance is not found, or an error instance.
    func invoke(id: Int) async -> Result<Asteroid?, Error> {
        await repository.asteroid(id)
    }
}
