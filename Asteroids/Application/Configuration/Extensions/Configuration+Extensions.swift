//
//  Configuration+Extensions.swift
//  Asteroids
//
//  Created by Daniel Safronov on 05.05.2022.
//

import Foundation

extension Configuration {
    /// Returns the configuration string value by its key.
    /// - parameter key: The configuration key.
    /// - returns: The configuration key value.
    static func requiredString(byKey key: String) -> String {
        string(byKey: key)!
    }
}
