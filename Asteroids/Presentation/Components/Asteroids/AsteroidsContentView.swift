//
//  AsteroidsListView.swift
//  Asteroids
//
//  Created by Daniel Safronov on 03.05.2022.
//

import UIKit

/// AsteroidsContentView class.
final class AsteroidsContentView: UIView, UITableViewDelegate, UITableViewDataSource {
    /// An instance of `UITableView` that represents a list of items.
    private lazy var tableView = UITableView()
    
    /// An instance of `EmptyStateView` that represents an empty state view.
    private lazy var emptyStateView = EmptyStateView()
    
    /// An instance of `LoadingStateView` that represents a loding state view.
    private lazy var loadingStateView = LoadingStateView()
    
    /// An instance of `UILayoutGuide` that describes the view content layout guide.
    private lazy var contentGuide = UILayoutGuide()
    
    /// An instance of `AsteroidsContentViewDelegateProtocol`.
    weak var delegate: AsteroidsContentViewDelegateProtocol?
    
    /// Initializes and returns a newly allocated view object.
    /// - returns: An initialized view object.
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configures the view elements.
    private func configure() {
        configureBackground()
        configureContentGuide()
        configureTableView()
        configureEmptyStateView()
        configureLoadingStateView()
    }
    
    /// Configures the view background.
    private func configureBackground() {
        backgroundColor = .systemBackground
    }
    
    /// Configures the view content layout guide.
    private func configureContentGuide() {
        addLayoutGuide(contentGuide)
        
        contentGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        contentGuide.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        contentGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        contentGuide.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    /// Configures the table view.
    private func configureTableView() {
        addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AsteroidCellView.self, forCellReuseIdentifier: AsteroidCellView.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: contentGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor).isActive = true
    }
    
    /// Configures the empty state view.
    private func configureEmptyStateView() {
        addSubview(emptyStateView)
        
        emptyStateView.isHidden = true
        
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.topAnchor.constraint(equalTo: contentGuide.topAnchor).isActive = true
        emptyStateView.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor).isActive = true
        emptyStateView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor).isActive = true
        emptyStateView.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor).isActive = true
    }
    
    /// Configure the loading state view
    private func configureLoadingStateView() {
        addSubview(loadingStateView)
        
        loadingStateView.isHidden = true
        
        loadingStateView.translatesAutoresizingMaskIntoConstraints = false
        loadingStateView.topAnchor.constraint(equalTo: contentGuide.topAnchor).isActive = true
        loadingStateView.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor).isActive = true
        loadingStateView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor).isActive = true
        loadingStateView.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor).isActive = true
    }

    /// Called to let you know that the user selected a row in the table.
    /// - parameter tableView: The table object whose row was selected.
    /// - parameter indexPath: The zero-based index of the row that was selected.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectRow(at: indexPath)
    }

    /// Tells the data source to return the number of rows in a given section of a table view.
    /// - parameter tableView: The table-view object requesting this information.
    /// - parameter section: An index number identifying a section in `tableView`.
    /// - returns: The number of rows in section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.numberOfRows() ?? 0
    }
    
    /// Asks the data source for a cell to insert in a particular location of the table view.
    /// - parameter tableView: A table-view object requesting the cell.
    /// - parameter indexPath: An index path locating a row in `tableView`.
    /// - returns: An object inheriting from `UITableViewCell` that the table view can use for the specified row. UIKit raises an assertion if you return nil.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AsteroidCellView.identifier, for: indexPath) as! AsteroidCellView
        let item = delegate?.item(forRowAt: indexPath)
        cell.update(for: item!)
        
        return cell
    }
    
    /// Inserts rows in the table view at the locations that an array of index paths identifies.
    /// - parameter indexes: An array of index path objects, each representing a row index and section index that together identify a row in the table view.
    func insertRows(at indexes: [IndexPath]) {
        tableView.insertRows(at: indexes, with: .fade)
    }
    
    /// Tells the delegate the table view is about to draw a cell for a particular row.
    /// - parameter tableView: The table view informing the delegate of this impending event.
    /// - parameter cell: A cell that `tableView` is going to use when drawing the row.
    /// - parameter indexPath: An index path locating the row in tableView.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRow = tableView.numberOfRows(inSection: indexPath.section) - 1
        
        if indexPath.row == lastRow {
            delegate?.didReachLastRow()
        }
    }
    
    /// Shows the empty state view.
    func showEmptyStateView() {
        emptyStateView.isHidden = false
        bringSubviewToFront(emptyStateView)
    }
    
    /// Hides the empty state view.
    func hideEmptyStateView() {
        emptyStateView.isHidden = true
        sendSubviewToBack(emptyStateView)
    }
    
    /// Shows the empty state view.
    func showLoadingStateView() {
        loadingStateView.startAnimating()
        loadingStateView.isHidden = false
        bringSubviewToFront(loadingStateView)
    }
    
    /// Hides the empty state view.
    func hideLoadingStateView() {
        loadingStateView.isHidden = true
        loadingStateView.stopAnimating()
        sendSubviewToBack(loadingStateView)
    }
}
