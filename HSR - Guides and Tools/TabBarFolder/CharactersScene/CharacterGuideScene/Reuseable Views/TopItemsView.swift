//
//  TopItemsView.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 22.09.2023.
//

import UIKit
import SDWebImage

final class TopItemsView: UIView {
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Items"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(items: [Item], header: String, frame: CGRect = .zero) {
        super.init(frame: frame)
        
        headerLabel.text = header
        addSubview(headerLabel)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        for item in items {
            let itemView = itemView(frame: .zero)
            itemView.titleLabel.text = item.name
            itemView.descriptionLabel.text = item.description
            itemView.commentLabel.text = item.comment
            if let url = URL(string: item.image) {
                itemView.imageView.sd_setImage(with: url, completed: nil)
            }
            stackView.addArrangedSubview(itemView)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

