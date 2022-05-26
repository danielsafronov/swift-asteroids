//
//  DefaultGetAsteroidsUseCase.swift
//  Asteroids
//
//  Created by Daniel Safronov on 04.05.2022.
//

import Foundation

/// DefaultGetAsteroidsUseCase structure.
struct DefaultGetAsteroidsUseCase: GetAsteroidsUseCase {
    /// An instance of `AsteroidRepository`.
    let repository: AsteroidRepository
    
    /// Returns a list of `Asteroid` instances for specified `page` and `size`.
    /// - parameter page: The list page.
    /// - parameter size: The number of list page items.
    /// - returns: The result instance with a list of `Asteroid` instances or an error instance.
    func invoke(page: Int, size: Int) async -> Result<[Asteroid], Error> {
        await repository.asteroids(size, fromPage: page)
    }
}
