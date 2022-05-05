//
//  AsteroidViewController.swift
//  Asteroids
//
//  Created by Daniel Safronov on 04.05.2022.
//

import Combine
import UIKit

/// AsteroidViewController class.
final class AsteroidViewController: UIViewController {
    /// The set of `AnyCancellable` instances.
    private lazy var cancellable = Set<AnyCancellable>()
    
    /// An instance of `Arguments`.
    private (set) var arguments: Arguments
    
    /// An instance of `AsteroidViewModel`.
    private lazy var viewModel = {
        AsteroidViewModel(
            asteroidId: arguments.asteroid.id,
            getAsteroidUseCase: ApplicationProvider.shared.serviceLocator.requireResolve()
        )
    }()
    
    /// Creates a view controller with the specified arguments.
    /// - parameter arguments: An instance of `Arguments`.
    /// - returns: A newly initialized `UIViewController` object.
    init(arguments: Arguments) {
        self.arguments = arguments
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        view = AsteroidContentView()
    }
    
    /// Notifies that view model's item  was changed.
    /// - parameter item: The changed view model's item.
    private func didChangeViewModelItem(_ item: Asteroid?) {
        guard let view = view as? AsteroidContentView else {
            return
        }
        
        guard let item = item else {
            view.showEmptyStateView()
            return
        }
        
        view.hideEmptyStateView()
        view.setTitleText(item.name)
        view.setDescriptionText(item.designation)
    }
    
    /// Notifies that view model's loading state was changed.
    /// - parameter state: The changed view model's loading state.
    private func didChangeViewModelLoading(_ state: Bool) {
        guard let view = view as? AsteroidContentView else {
            return
        }
        
        state ? view.showLoadingStateView() : view.hideLoadingStateView()
    }
    
    /// Registers the controller observers.
    private func observe() {
        observeViewModelItem()
        observeViewModelLoading()
    }
    
    /// Registers the view model item observer.
    private func observeViewModelItem() {
        viewModel.$item
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] item in
                self?.didChangeViewModelItem(item)
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
}

extension AsteroidViewController {
    /// Arguments structure.
    struct Arguments {
        let asteroid: Asteroid
    }
}
