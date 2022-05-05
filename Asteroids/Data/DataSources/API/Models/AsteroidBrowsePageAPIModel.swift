//
//  AsteroidBrowsePageAPIModel.swift
//  Asteroids
//
//  Created by Daniel Safronov on 04.05.2022.
//

import Foundation

/// AsteroidBrowsePageAPIModel structure.
struct AsteroidBrowsePageAPIModel: Codable {
    let size: Int
    let page: Int
    let totalPageCount: Int
    let totalItemCount: Int
    
    enum CodingKeys: String, CodingKey {
        case size
        case page = "number"
        case totalPageCount = "total_pages"
        case totalItemCount = "total_elements"
    }
}
