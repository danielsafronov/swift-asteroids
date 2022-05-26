//
//  DefaultAsteroidRepository.swift
//  Asteroids
//
//  Created by Daniel Safronov on 04.05.2022.
//

import Foundation

/// DefaultAsteroidRepository structure.
struct DefaultAsteroidRepository: AsteroidRepository {
    /// An instance of `AsteroidDataSource`.
    let dataSource: AsteroidDataSource
    
    /// Returns a list of `Asteroid` instances for specified `page` and `size`.
    /// - parameter size: The number of list page items.
    /// - parameter page: The list page.
    /// - returns: The result instance with a list of `Asteroid` instances or an error instance.
    func asteroids(_ size: Int, fromPage page: Int) async -> Result<[Asteroid], Error> {
        await dataSource.asteroids(size, fromPage: page)
    }
    
    /// Returns an instance of `Asteroid` by specified identifier or `nil`.
    /// - parameter id: The identifier of the `Asteroid` instance.
    /// - returns: The result instance with instance of `Asteroid` if instance exists, `nil` if instance is not found, or an error instance.
    func asteroid(_ id: Int) async -> Result<Asteroid?, Error> {
        await dataSource.asteroid(id)
    }
}
