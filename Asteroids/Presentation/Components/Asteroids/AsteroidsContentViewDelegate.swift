//
//  AsteroidsContentViewDelegate.swift
//  Asteroids
//
//  Created by Daniel Safronov on 04.05.2022.
//

import Foundation

/// AsteroidsContentViewDelegate protocol.
protocol AsteroidsContentViewDelegate: AnyObject {
    /// Tells the delegate to return the number of rows.
    /// - returns: The number of rows.
    func numberOfRows() -> Int
    
    /// Tells the delegate to return the instance of `Asteroid` for row at specified index.
    /// - parameter indexPath: The row index.
    /// - returns: The instance of `Asteroid` or `nil`.
    func item(forRowAt indexPath: IndexPath) -> Asteroid?
    
    /// Tells the delegate that the last row did reached.
    func didReachLastRow()
    
    /// Tells the delegate that the row did selected.
    /// - parameter indexPath: The selected row index.
    func didSelectRow(at indexPath: IndexPath)
}
