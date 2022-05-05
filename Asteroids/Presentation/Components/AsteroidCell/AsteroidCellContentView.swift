//
//  AsteroidCellContentView.swift
//  Asteroids
//
//  Created by Daniel Safronov on 03.05.2022.
//

import UIKit

/// AsteroidCellContentView class.
final class AsteroidCellContentView: UIView {
    /// An instance of `UILabel` that represents the view title.
    private lazy var titleLabel = UILabel()
    
    /// An instance of `UILabel` that represents the view description.
    private lazy var descriptionLabel = UILabel()
    
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
        configureContentGuide()
        configureTitleLabel()
        configureDescriptionLabel()
    }
    
    /// Configures the view content layout guide.
    private func configureContentGuide() {
        addLayoutGuide(contentGuide)
        
        contentGuide.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        contentGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
        contentGuide.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        contentGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
    }
    
    /// Configures the title view.
    private func configureTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.text = "Hello World"
        titleLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        titleLabel.numberOfLines = 1
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor).isActive = true
    }
    
    /// Configures the description view.
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        
        descriptionLabel.text = "Description Label"
        descriptionLabel.font = .systemFont(ofSize: 14.0, weight: .light)
        descriptionLabel.numberOfLines = 3
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5.0).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor).isActive = true
    }
    
    /// Clears the title view and description view.
    func cleanup() {
        setTitleText("")
        setDescriptionText("")
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
}
