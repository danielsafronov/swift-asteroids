//
//  GetAsteroidUseCase.swift
//  Asteroids
//
//  Created by Daniel Safronov on 04.05.2022.
//

import Foundation

/// GetAsteroidUseCase protocol.
protocol GetAsteroidUseCase {
    /// Returns an instance of `Asteroid` by specified identifier or `nil`.
    /// - parameter id: The identifier of the `Asteroid` instance.
    /// - returns: The result instance with instance of `Asteroid` if instance exists, `nil` if instance is not found, or an error instance.
    func invoke(id: Int) async -> Result<Asteroid?, Error>
}
