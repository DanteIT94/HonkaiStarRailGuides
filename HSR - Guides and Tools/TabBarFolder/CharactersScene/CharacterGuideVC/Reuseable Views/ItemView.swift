//
//  ItemView.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 21.09.2023.
//

import UIKit

final class itemView: UIView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var verticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView,
                                                   titleLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var mainStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [verticalStack, descriptionLabel])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mainStack)
        addSubview(commentLabel)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: self.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            commentLabel.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 8),
            commentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            commentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: mainStack.trailingAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
