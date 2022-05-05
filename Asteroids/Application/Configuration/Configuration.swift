//
//  Configuration.swift
//  Asteroids
//
//  Created by Daniel Safronov on 05.05.2022.
//

import Foundation

/// Configuration structure.
struct Configuration {
    /// Returns the configuration string value by its key or `nil`.
    /// - parameter key: The configuration key.
    /// - returns: The configuration key value or `nil`.
    static func string(byKey key: String) -> String? {
        guard let object = object(byKey: key),
              let value = object as? String
        else {
            return nil
        }
        
        return value
    }
    
    /// Returns the configuration object value by its key or `nil`.
    /// - parameter key: The configuration key.
    /// - returns: The configuration key value or `nil`.
    private static func object(byKey key: String) -> Any? {
        Bundle.main.object(forInfoDictionaryKey: key)
    }
}
