//
//  AsteroidAPIModel+Extensions.swift
//  Asteroids
//
//  Created by Daniel Safronov on 04.05.2022.
//

import Foundation

extension AsteroidAPIModel {
    /// Map an instance of `AsteroidAPIModel` to an instance of `Asteroid`.
    /// - returns: An instance of `Asteroid`.
    func map() -> Asteroid {
        Asteroid(
            id: Int(id)!,
            name: name,
            designation: designation
        )
    }
}
