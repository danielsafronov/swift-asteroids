//
//  AsteroidsViewController.swift
//  Asteroids
//
//  Created by Daniel Safronov on 03.05.2022.
//

import Combine
import UIKit

/// AsteroidsViewController class.
final class AsteroidsViewController: UIViewController {
    /// An instance of `AsteroidsViewControllerDelegate`.
    weak var delegate: AsteroidsViewControllerDelegate?
    
    /// The set of `AnyCancellable` instances.
    private lazy var cancellable = Set<AnyCancellable>()
    
    /// An instance of `LoadingStateView` that represents a loding state view.
    private lazy var loadingStateView = LoadingStateView()
        
    /// An instance of `AsteroidsViewModel`.
    private lazy var viewModel = {
        AsteroidsViewModel(
            getAsteroidsUseCase: ApplicationProvider.shared.serviceLocator.requireResolve()
        )
    }()
    
    /// Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
                
        configure()
        observe()
    }
    
    /// Notifies the view controller that its view was added to a view hierarchy.
    /// - parameter animated: If true, the view was added to the window using an animation.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.load()
    }
    
    /// Creates the view that the controller manages.
    override func loadView() {
        view = AsteroidsContentView()
    }
    
    /// Configures the view controller's elements.
    private func configure() {
        configureView()
        configureNavigationController()
    }
    
    /// Configures the view controller's view.
    private func configureView() {
        guard let view = view as? AsteroidsContentView else {
            return
        }
        
        view.delegate = self
    }
    
    /// Configurest the navigation view controller.
    private func configureNavigationController() {
        guard let navigationController = navigationController else {
            return
        }
        
        navigationController.navigationBar.topItem?.titleView = loadingStateView
    }
    
    /// Notifies that view model's item list was changed.
    /// - parameter items: The changed list of view model's items.
    private func didChangeViewModelItems(_ items: [Asteroid]) {
        guard let view = view as? AsteroidsContentView else {
            return
        }
        
        if !items.isEmpty {
            let indexes = viewModel.indexes(forPage: viewModel.page)
            view.hideEmptyStateView()
            view.insertRows(at: indexes)
        } else {
            view.showEmptyStateView()
        }
    }
    
    /// Notifies that view model's loading state was changed.
    /// - parameter state: The changed view model's loading state.
    private func didChangeViewModelLoading(_ state: Bool) {
        guard let view = view as? AsteroidsContentView else {
            return
        }
        
        state ? view.showLoadingStateView() : view.hideLoadingStateView()
    }
    
    /// Notifies that view model's loading more state was changed.
    /// - parameter state: The changed view model's loading more state.
    private func didChangeViewModelLoadingMore(_ state: Bool) {
        state ? loadingStateView.startAnimating() : loadingStateView.stopAnimating()
    }
    
    /// Registers the controller observers.
    private func observe() {
        observeViewModelItems()
        observeViewModelLoading()
        observeViewModelLoadingMore()
    }
    
    /// Registers the controller observers.
    private func observeViewModelItems() {
        viewModel.$items
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.didChangeViewModelItems(items)
            }
            .store(in: &cancellable)
    }
    
    /// Registers the view model loading observer.
    private func observeViewModelLoading() {
        viewModel.$loading
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.didChangeViewModelLoading(state)
            }
            .store(in: &cancellable)
    }
    
    /// Registers the view model loading observer.
    private func observeViewModelLoadingMore() {
        viewModel.$loadingMore
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.didChangeViewModelLoadingMore(state)
            }
            .store(in: &cancellable)
    }
}

extension AsteroidsViewController: AsteroidsContentViewDelegate {    
    /// Tells the delegate to return the number of rows.
    /// - returns: The number of rows.
    func numberOfRows() -> Int {
        viewModel.items.count
    }
    
    /// Tells the delegate to return the instance of `Asteroid` for row at specified index.
    /// - parameter indexPath: The row index.
    /// - returns: The instance of `Asteroid` or `nil`.
    func item(forRowAt indexPath: IndexPath) -> Asteroid? {
        viewModel.item(at: indexPath)
    }
    
    /// Tells the delegate that the last row did reached.
    func didReachLastRow() {
        viewModel.loadMore()
    }
    
    /// Tells the delegate that the row did selected.
    /// - parameter indexPath: The selected row index.
    func didSelectRow(at indexPath: IndexPath) {
        guard let item = viewModel.item(at: indexPath) else {
            return
        }
        
        delegate?.didSelectAsteroid(asteroidId: item.id)
    }
}
