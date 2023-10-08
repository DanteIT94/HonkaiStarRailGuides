//
//  StatsView.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 24.09.2023.
//

import UIKit

final class StatsView: UIView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Лучшие характеристики"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    let mainVerticalLabel: UILabel = {
        let label = UILabel()
        label.text = "Основные"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    let additionalLabel: UILabel = {
       let label = UILabel()
        label.text = "Доп."
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let additionalCommentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(headerLabel)
        addSubview(mainVerticalLabel)
        addSubview(mainStack)
        addSubview(additionalLabel)
        addSubview(additionalCommentLabel)
        
        ["Тело", "Ноги", "Сфера", "Цепь"].forEach { text in
            let mainLabel = UILabel()
            mainLabel.text = text
            mainLabel.font = UIFont.boldSystemFont(ofSize: 14)
            mainLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
            
            let commentLabel = UILabel()
            commentLabel.numberOfLines = 0
            commentLabel.font = UIFont.systemFont(ofSize: 14)
            
            let horizontalStack = UIStackView(arrangedSubviews: [mainLabel, commentLabel])
            horizontalStack.axis = .horizontal
            horizontalStack.alignment = .center
            
            mainStack.addArrangedSubview(horizontalStack)
        }
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        mainVerticalLabel.translatesAutoresizingMaskIntoConstraints = false
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        additionalCommentLabel.translatesAutoresizingMaskIntoConstraints = false
        additionalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            mainVerticalLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            mainVerticalLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            mainVerticalLabel.widthAnchor.constraint(equalToConstant: 100),
            mainVerticalLabel.centerYAnchor.constraint(equalTo: mainStack.centerYAnchor),
            
            mainStack.topAnchor.constraint(equalTo: mainVerticalLabel.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: mainVerticalLabel.trailingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            additionalLabel.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 8),
            additionalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            additionalLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            additionalLabel.widthAnchor.constraint(equalToConstant: 50),
            
            additionalCommentLabel.topAnchor.constraint(equalTo: additionalLabel.topAnchor),
            additionalCommentLabel.leadingAnchor.constraint(equalTo: mainVerticalLabel.trailingAnchor),
            additionalCommentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            additionalCommentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func updateComments(mainStatsComment: [String], additionalStatsComment: String) {
        for (index, comment) in mainStatsComment.enumerated() {
            if mainStack.arrangedSubviews.count > index,
               let horizontalStack = mainStack.arrangedSubviews[index] as? UIStackView,
               let commentLabel = horizontalStack.arrangedSubviews.last as? UILabel {
                commentLabel.text = comment
            }
        }
        additionalCommentLabel.text = additionalStatsComment
    }
}

