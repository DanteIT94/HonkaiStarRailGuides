//
//  InfoModalViewController.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 01.10.2023.
//

import UIKit

final class InfoModalViewController: UIViewController {
    var titleText: String?
    var infoText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        let contentBackgroundView = UIView()
        contentBackgroundView.backgroundColor = .white
        contentBackgroundView.layer.cornerRadius = 16
        contentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentBackgroundView)
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.isUserInteractionEnabled = false
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        //Stack
        let titleLabel = UILabel()
        titleLabel.text = titleText
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        
        let infoLabel = UILabel()
        infoLabel.text = infoText
        infoLabel.font = UIFont.systemFont(ofSize: 10)
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .left
        
        let okButton = UIButton(type: .system)
        okButton.setTitle("Понятно", for: .normal)
        okButton.addTarget(self, action: #selector(closeModalView), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, infoLabel, okButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentBackgroundView.addSubview(stackView)
        view.addSubview(contentBackgroundView)
        
        NSLayoutConstraint.activate([
            contentBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentBackgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentBackgroundView.widthAnchor.constraint(equalToConstant: 300),
            contentBackgroundView.heightAnchor.constraint(equalToConstant: 400),
            
            stackView.centerXAnchor.constraint(equalTo: contentBackgroundView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentBackgroundView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentBackgroundView.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func closeModalView() {
        print("closeModalView called")
        dismiss(animated: true)
    }
}
