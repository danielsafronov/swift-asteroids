//
//  ApplicationProvider+Extensions.swift
//  Asteroids
//
//  Created by Daniel Safronov on 04.05.2022.
//

import Foundation
import ServiceLocator

extension ApplicationProvider {
    init() {
        self.init(serviceLocator: ServiceLocator())
    }
}

extension ApplicationProvider {
    static let shared: ApplicationProvider = {
        let provider = ApplicationProvider()
        provider.bootstrap()
        
        return provider
    }()
}
