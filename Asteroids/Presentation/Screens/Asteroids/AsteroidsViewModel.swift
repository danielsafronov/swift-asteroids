//
//  AsteroidsViewModel.swift
//  Asteroids
//
//  Created by Daniel Safronov on 03.05.2022.
//

import Combine
import Foundation

/// AsteroidsViewModel class.
final class AsteroidsViewModel {
    /// The list of `Asteroid` instances.
    @Published var items: [Asteroid] = []
    
    /// The loading flag.
    @Published var loading: Bool = false
    
    /// The loading more flag.
    @Published var loadingMore: Bool = false
    
    /// The end reached flag.
    private var isEndReached: Bool = false
    
    /// An instance of `GetAsteroidsUseCaseProtocol`.
    private let getAsteroidsUseCase: GetAsteroidsUseCaseProtocol
    
    /// The `Task` instance that performs the load process.
    private var loadTask: Task<Void, Never>?
    
    /// The page number.
    private (set) var page: Int = 0
    
    /// The number of items per page.
    private (set) var size: Int = 20
    
    /// Creates a new instance of `AsteroidsViewModel`.
    /// - parameter getAsteroidsUseCase: An instance of `GetAsteroidsUseCaseProtocol`.
    /// - returns: An instance of `AsteroidsViewModel`.
    init(getAsteroidsUseCase: GetAsteroidsUseCaseProtocol) {
        self.getAsteroidsUseCase = getAsteroidsUseCase
    }
    
    /// Performs the deinitialization process for the `AsteroidsViewModel` instance.
    deinit {
        loadTask?.cancel()
    }
    
    /// Performs the load data process.
    func load() {
        guard loadTask == nil, items.isEmpty else {
            return
        }
        
        loadTask = Task(priority: .high) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.loading = true
            await self.loadAsync(withReset: true)
            
            self.loading = false
            self.loadTask = nil
        }
    }
    
    /// Performs an asynchronous data loading process.
    /// - parameter reset: A flag indicating that previous data should be reset.
    private func loadAsync(withReset reset: Bool = false) async {
        let page = page
        let size = size
        let result = await loadItemsAsync(size, forPage: page)
        
        guard case let .success(resultItems) = result else {
            return
        }
        
        items = reset ? resultItems : items + resultItems
        if resultItems.count < size {
            isEndReached = true
        }
    }
    
    /// Performs the load more data process.
    func loadMore() {
        guard loadTask == nil, !isEndReached else {
            return
        }
                
        loadTask = Task(priority: .high) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.loadingMore = true
            self.page += 1
            await self.loadAsync(withReset: false)
            
            self.loadingMore = false
            self.loadTask = nil
        }
    }
    
    /// Performs an asynchronous items loading process.
    /// - parameter size: The items count.
    /// - parameter page: The page number.
    /// - returns: A result instance with a list of items, or with an error instance.
    private func loadItemsAsync(_ size: Int, forPage page: Int) async -> Result<[Asteroid], Error> {
        await getAsteroidsUseCase.invoke(page: page, size: size)
    }
    
    /// Returns the list of `IndexPath` instances for the specified page number.
    /// - parameter page: The page number.
    /// - returns: The list of `IndexPath` instances.
    func indexes(forPage page: Int) -> [IndexPath] {
        let page = page + 1
        var range = indexRange(page, fromPage: page - 1)
        let itemCountDiff = abs(page * range.count - items.count)
        if itemCountDiff > 0 {
            range.removeLast(itemCountDiff)
        }
        
        return indexes(forRange: range)
    }
    
    /// Returns the index range for the specified page number from the specified page number.
    /// - parameter page: The page number.
    /// - parameter fromPage: The page number on which the range starts.
    /// - returns: The index range.
    private func indexRange(_ page: Int, fromPage: Int) -> Range<Int> {
        let itemCount = size
        let firstIndex = (fromPage * itemCount)
        let lastIndex = (page * itemCount)
        
        return firstIndex..<lastIndex
    }
    
    /// Returns the list of `IndexPath` instances for the specified index range.
    /// - parameter range: The index range.
    /// - returns: The list of `IndexPath` instances.
    private func indexes(forRange range: Range<Int>) -> [IndexPath] {
        range.map { index in
            IndexPath(row: index, section: 0)
        }
    }
    
    /// Returns the `Asteroid` instance for the specified index.
    /// - parameter indexPath: The index of the `Asteroid` instance.
    /// - returns: The instance of `Asteroid` or `nil`.
    func item(at indexPath: IndexPath) -> Asteroid? {
        let index = indexPath.row
        guard items.indices.contains(index) else {
            return nil
        }

        return items[index]
    }
}
