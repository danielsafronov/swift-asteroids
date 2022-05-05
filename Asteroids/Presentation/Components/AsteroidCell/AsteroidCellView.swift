//
//  AsteroidCellView.swift
//  Asteroids
//
//  Created by Daniel Safronov on 03.05.2022.
//

import UIKit

/// AsteroidCellView class.
final class AsteroidCellView: UITableViewCell {
    /// The `AsteroidCellView` identifier.
    static let identifier = "asteroid-cell-view"
    
    /// An instance of `AsteroidCellContentView` that represents the cell content view.
    private lazy var cellContentView = AsteroidCellContentView()
    
    /// Initializes a table cell with a style and a reuse identifier and returns it to the caller.
    /// - parameter style: A constant indicating a cell style.
    /// - parameter reuseIdentifier: A string used to identify the cell object if it is to be reused for drawing multiple rows of a table view. Pass nil if the cell object is not to be reused. You should use the same reuse identifier for all cells of the same form.
    /// - returns: An initialized `UITableViewCell` object or nil if the object could not be created.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Prepares a reusable cell for reuse by the table view's delegate.
    override func prepareForReuse() {
        super.prepareForReuse()
        cellContentView.cleanup()
    }
    
    /// Configures the view elements.
    private func configure() {
        contentView.addSubview(cellContentView)
        
        cellContentView.translatesAutoresizingMaskIntoConstraints = false
        cellContentView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cellContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        cellContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cellContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    /// Updates the view elements for the specified item.
    /// - parameter item: An instance of `Asteroid`.
    func update(for item: Asteroid) {
        cellContentView.setTitleText(item.name)
        cellContentView.setDescriptionText(item.designation)
    }
}
