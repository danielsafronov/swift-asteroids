//
//  AsteroidAPIDataSource.swift
//  Asteroids
//
//  Created by Daniel Safronov on 04.05.2022.
//

import Foundation
import HttpClient

/// AsteroidAPIDataSource structure.
struct AsteroidAPIDataSource: AsteroidDataSourceProtocol {
    /// An instance of HttpClientProtocol.
    let httpClient: HttpClientProtocol
    
    /// Returns a list of `Asteroid` instances for specified `page` and `size`.
    /// - parameter size: The number of list page items.
    /// - parameter page: The list page.
    /// - returns: The result instance with a list of `Asteroid` instances or an error instance.
    func asteroids(_ size: Int, fromPage page: Int) async -> Result<[Asteroid], Error> {
        let apiKey = Configuration.requiredString(byKey: "API_KEY")
        let result: Result<AsteroidBrowseAPIModel, Error> = await httpClient.request(
            with: HttpClientRequestParameters(
                url: "https://www.neowsapp.com/rest/v1/neo/browse",
                method: .get,
                queryParameters: [
                    "page": String(page),
                    "size": String(size),
                    "api_key": apiKey,
                ]
            )
        )
        
        return result.map { $0.items.map { $0.map() }}
    }
    
    /// Returns an instance of `Asteroid` by specified identifier or `nil`.
    /// - parameter id: The identifier of the `Asteroid` instance.
    /// - returns: The result instance with instance of `Asteroid` if instance exists, `nil` if instance is not found, or an error instance.
    func asteroid(_ id: Int) async -> Result<Asteroid?, Error> {
        let apiKey = Configuration.requiredString(byKey: "API_KEY")
        let result: Result<AsteroidAPIModel, Error> = await httpClient.request(
            with: HttpClientRequestParameters(
                url: "https://api.nasa.gov/neo/rest/v1/neo/\(id)",
                method: .get,
                queryParameters: [
                    "api_key": apiKey,
                ]
            )
        )
        
        return result.map { $0.map() }
    }
}
