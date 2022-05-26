//
//  AsteroidViewModel.swift
//  Asteroids
//
//  Created by Daniel Safronov on 04.05.2022.
//

import Foundation

/// AsteroidViewModel class.
final class AsteroidViewModel {
    /// The list of `Asteroid` instances.
    @Published var item: Asteroid?
    
    /// The loading flag.
    @Published var loading: Bool = false
    
    /// The asteroid identifier.
    private let asteroidId: Int
    
    /// An instance of `GetAsteroidUseCase`.
    private let getAsteroidUseCase: GetAsteroidUseCase
    
    /// The `Task` instance that performs the load process.
    private var loadTask: Task<Void, Never>?
    
    /// Creates a new instance of `AsteroidViewModel`.
    /// - parameter asteroidId: The asteroid identifier.
    /// - parameter getAsteroidUseCase: An instance of `GetAsteroidUseCase`.
    /// - returns: An instance of `AsteroidViewModel`.
    init(asteroidId: Int, getAsteroidUseCase: GetAsteroidUseCase) {
        self.asteroidId = asteroidId
        self.getAsteroidUseCase = getAsteroidUseCase
    }
    
    /// Performs the deinitialization process for the `AsteroidsViewModel` instance.
    deinit {
        loadTask?.cancel()
    }
    
    /// Performs the load data process.
    func load() {
        guard loadTask == nil else {
            return
        }
        
        loadTask = Task(priority: .high) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.loading = true
            await self.loadAsync()
            
            self.loading = false
            self.loadTask = nil
        }
    }
    
    /// Performs an asynchronous data loading process.
    private func loadAsync() async {
        let result = await getAsteroidUseCase.invoke(id: asteroidId)
        guard case let .success(resultItem) = result else {
            return
        }
        
        item = resultItem
    }
}
