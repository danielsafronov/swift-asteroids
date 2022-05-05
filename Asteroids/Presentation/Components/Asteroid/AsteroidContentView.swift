//
//  AsteroidContentView.swift
//  Asteroids
//
//  Created by Daniel Safronov on 04.05.2022.
//

import UIKit

/// AsteroidContentView class.
final class AsteroidContentView: UIView {
    /// An instance of `UILabel` that represents a title view description.
    private lazy var titleLabel = UILabel()
    
    /// An instance of `UILabel` that represents an empty view description.
    private lazy var descriptionLabel = UILabel()
    
    /// An instance of `EmptyStateView` that represents an empty state view.
    private lazy var emptyStateView = EmptyStateView()
    
    /// An instance of `LoadingStateView` that represents a loding state view.
    private lazy var loadingStateView = LoadingStateView()
    
    /// An instance of `UILayoutGuide` that describes the view content layout guide.
    private lazy var contentGuide = UILayoutGuide()
    
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
        configureTitleLabel()
        configureDescriptionLabel()
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

        contentGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        contentGuide.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20.0).isActive = true
        contentGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        contentGuide.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
    }
    
    /// Configures the description label view.
    private func configureTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.font = .systemFont(ofSize: 24.0, weight: .bold)
        titleLabel.numberOfLines = 1
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor).isActive = true
    }
    
    /// Configures the description label view.
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        
        descriptionLabel.font = .systemFont(ofSize: 16.0, weight: .regular)
        descriptionLabel.numberOfLines = 1
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor).isActive = true
    }
    
    /// Configure the empty state view
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
    
    /// Sets the specified text as the text for the title view.
    /// - parameter text: The text for the title view.
    func setTitleText(_ text: String) {
        titleLabel.text = text
    }
    
    /// Sets the specified text as the text for the description view.
    /// - parameter text: The text for the description view.
    func setDescriptionText(_ text: String) {
        descriptionLabel.text = text
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
