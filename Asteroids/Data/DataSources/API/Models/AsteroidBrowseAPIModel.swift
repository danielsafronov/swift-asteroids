//
//  AsteroidBrowseAPIModel.swift
//  Asteroids
//
//  Created by Daniel Safronov on 04.05.2022.
//

import Foundation

/// AsteroidBrowseAPIModel structure.
struct AsteroidBrowseAPIModel: Codable {
    let items: [AsteroidAPIModel]
    let page: AsteroidBrowsePageAPIModel
    
    enum CodingKeys: String, CodingKey {
        case items = "near_earth_objects"
        case page
    }
}
