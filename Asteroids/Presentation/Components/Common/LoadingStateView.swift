//
//  LoadingStateView.swift
//  Asteroids
//
//  Created by Daniel Safronov on 05.05.2022.
//

import UIKit

/// LoadingStateView class.
final class LoadingStateView: UIView {
    /// An instance of `UIActivityIndicatorView` that represents a loading indicator view.
    private lazy var indicatorView = UIActivityIndicatorView(style: .medium)
    
    /// Initializes and returns a newly allocated view object.
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configures the view items.
    private func configure() {
        configureBackground()
        configureIndicatorView()
    }
    
    /// Configures the view background.
    private func configureBackground() {
        backgroundColor = .systemBackground
    }
    
    /// Configures the loading indicator view.
    private func configureIndicatorView() {
        addSubview(indicatorView)
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    /// Starts the loading indicator view animation.
    func startAnimating() {
        indicatorView.startAnimating()
    }
    
    /// Starts the loading indicator view animation.
    func stopAnimating() {
        indicatorView.stopAnimating()
    }
}
