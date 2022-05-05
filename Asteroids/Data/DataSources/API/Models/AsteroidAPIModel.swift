//
//  AsteroidAPIModel.swift
//  Asteroids
//
//  Created by Daniel Safronov on 04.05.2022.
//

import Foundation

/// AsteroidAPIModel structure.
struct AsteroidAPIModel: Codable {
    let id: String
    let name: String
    let designation: String
}
