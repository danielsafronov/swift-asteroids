//
//  ApplicationProvider.swift
//  Asteroids
//
//  Created by Daniel Safronov on 04.05.2022.
//

import Foundation
import ServiceLocator
import HttpClient

/// ApplicationProvider class.
struct ApplicationProvider {
    /// An instance of `ServiceLocator`.
    let serviceLocator: ServiceLocator
    
    /// Creates a new instance of `ApplicationProvider`.
    /// - parameter serviceLocator: An instance of `ServiceLocator`.
    /// - returns: An instance of `ApplicationProvider`.
    init(serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }
    
    /// Performs the bootstrap process.
    func bootstrap() {
        bootstrapHttpClient()
        bootstrapDataSources()
        bootstrapRepositories()
        bootstrapUseCases()
    }
    
    /// Performs the http client bootstrap process.
    private func bootstrapHttpClient() {
        serviceLocator.register(
            abstraction: HttpClientProtocol.self,
            concrete: HttpClientBuilder()
                .build()
        )
    }
    
    /// Executes the data sources bootstrap process.
    private func bootstrapDataSources() {
        serviceLocator.register(
            abstraction: AsteroidDataSourceProtocol.self,
            concrete: AsteroidAPIDataSource(
                httpClient: serviceLocator.requireResolve()
            )
        )
    }
    
    /// Executes the repositories bootstrap process.
    private func bootstrapRepositories() {
        serviceLocator.register(
            abstraction: AsteroidRepositoryProtocol.self,
            concrete: AsteroidRepository(
                dataSource: serviceLocator.requireResolve()
            )
        )
    }
    
    /// Executes the use cases bootstrap process.
    private func bootstrapUseCases() {
        let repository: AsteroidRepositoryProtocol = serviceLocator.requireResolve()
        
        serviceLocator.register(
            abstraction: GetAsteroidsUseCaseProtocol.self,
            concrete: GetAsteroidsUseCase(
                repository: repository
            )
        )
        
        serviceLocator.register(
            abstraction: GetAsteroidUseCaseProtocol.self,
            concrete: GetAsteroidUseCase(
                repository: repository
            )
        )
    }
}
