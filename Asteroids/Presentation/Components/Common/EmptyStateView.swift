//
//  EmptyContentView.swift
//  Asteroids
//
//  Created by Daniel Safronov on 03.05.2022.
//

import UIKit

/// EmptyStateView class.
final class EmptyStateView: UIView {
    /// An instance of `UILabel` that represents an empty view description.
    private lazy var descriptionLabel = UILabel()
    
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
        configureDescriptionLabel()
    }
    
    /// Configures the view background.
    private func configureBackground() {
        backgroundColor = .systemBackground
    }
    
    /// Configures the description label view.
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        
        descriptionLabel.text = "No data"
        descriptionLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        descriptionLabel.numberOfLines = 1
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
