//
//  VerticalLabelStackView.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 19.08.2023.
//

import UIKit

final class VerticalLabelsStackView: UIStackView {
    
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
            
            if index == 0 || index == 2 {
                addInfoButton(to: container, withIndex: index)
            }
            
            container.addSubview(label)
            container.layer.cornerRadius = 2.0
            container.clipsToBounds = true
            container.layer.borderWidth = 1.0
            container.layer.borderColor = UIColor.gray.cgColor
            
            if index % 2 == 0 {
                let spacer = UIView()
                spacer.translatesAutoresizingMaskIntoConstraints = false
                addArrangedSubview(spacer)
                
                NSLayoutConstraint.activate([
                    spacer.heightAnchor.constraint(equalToConstant: 3.0)])
            }
            
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
    
    func updateLabels(with texts: [String]) {
        guard texts.count == labels.count else {
            print("Колличество текстов должно соответствовать количеству лейблов")
            return
        }
        
        for (index, newText) in texts.enumerated() {
            labels[index].text = newText
        }
    }
    
    private func addInfoButton(to container: UIView, withIndex index: Int) {
        let button = UIButton(type: .infoLight)
        button.tag = index
        button.addTarget(self, action: #selector(infoButtonTapped(_ :)), for: .touchUpInside)
        button.setImage(UIImage(systemName: "questionmark.bubble.fill"), for: .normal)
        button.tintColor = .black
        container.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            button.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 20),
            button.heightAnchor.constraint(equalTo: button.widthAnchor)
        ])
    }
    
    //Поиск текущего View
    func findViewController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        while nextResponder != nil {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            nextResponder = nextResponder?.next
        }
        return nil
    }
    
    
    @objc private func infoButtonTapped(_ sender: UIButton) {
        print("нажатие на Info")
        let index = sender.tag
        var titleText: String = ""
        var infoText: String = ""
        
        if index == 0 {
            titleText = "Что значат значения в тир листе?"
            infoText = "\(Texts.Tier.SPlus)" + "\n\(Texts.Tier.S)" + "\n\(Texts.Tier.A)" + "\n\(Texts.Tier.B)" + "\n\(Texts.Tier.C)"
        } else if index == 2 {
            titleText = "Роль в команде"
            infoText = "\(Texts.Role.MainDPS)" + "\n\(Texts.Role.SubDPS)" + "\n\(Texts.Role.Tank)" + "\n\(Texts.Role.Buffer)" + "\n\(Texts.Role.Debuffer)" + "\n\(Texts.Role.Healer)" + "\n\(Texts.Role.Support)"
        }
        
        if let viewController = findViewController() {
            let infoModalVC = InfoModalViewController()
            infoModalVC.titleText = titleText
            infoModalVC.infoText = infoText
            infoModalVC.modalPresentationStyle = .overCurrentContext
            viewController.present(infoModalVC, animated: true)
        }
    }

}

//#Preview {
//    let character = MockData.shared.mockCharacter
//    return CharacterGuideVC(character: character)
//}
