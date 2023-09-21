//
//  VerticalLabelStackView.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 19.08.2023.
//

import UIKit

class VerticalLabelsStackView: UIStackView {
    
    private var labels: [UILabel] = []
    
    init(labelsText: [String]) {
        super.init(frame: .zero)
        
        for (index, text) in labelsText.enumerated() {
            let label = UILabel()
            label.text = text
            label.backgroundColor = .clear
            label.textAlignment = .center
            label.layer.borderWidth = 1.0
            label.layer.borderColor = UIColor.gray.cgColor
            labels.append(label)
            
            let container = UIView()
            // Чередование цветов
            if index % 2 == 0 {
                container.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1) // бежевый
            } else {
                container.backgroundColor = UIColor(red: 255/255, green: 230/255, blue: 230/255, alpha: 1) // слегка розоватый цвет
            }
            
            container.addSubview(label)
            container.layer.cornerRadius = 5.0
            container.clipsToBounds = true
            container.layer.borderWidth = 1.0
            container.layer.borderColor = UIColor.gray.cgColor
            
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: container.topAnchor),
                label.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                label.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: container.trailingAnchor)
            ])
            addArrangedSubview(container)
        }
        configureStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStackView() {
        self.axis = .vertical
        self.distribution = .fillEqually
        self.alignment = .fill
        self.spacing = 0
    }
    
}
