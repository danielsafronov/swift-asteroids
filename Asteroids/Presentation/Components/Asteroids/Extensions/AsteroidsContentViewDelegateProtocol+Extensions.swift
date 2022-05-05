//
//  AsteroidsContentViewDelegateProtocol+Extensions.swift
//  Asteroids
//
//  Created by Daniel Safronov on 04.05.2022.
//

import Foundation

/// AsteroidsContentViewDelegateProtocol protocol.
extension AsteroidsContentViewDelegateProtocol {
    /// Tells the delegate that the last row did reached.
    func didReachLastRow() {}
    
    /// Tells the delegate that the row did selected.
    /// - parameter indexPath: The selected row index.
    func didSelectRow(at indexPath: IndexPath) {}
}
