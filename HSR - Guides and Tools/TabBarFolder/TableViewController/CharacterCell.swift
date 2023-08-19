//
//  CharacterCell.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 16.08.2023.

import UIKit
import FirebaseStorage
import SDWebImage

final class CharacterCell: UITableViewCell {
    
    
    let cellUIView: UIView = {
        let UIView = UIView()
        return UIView
    }()
    
    let characterIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        // ... другие настройки, если они нужны
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "default_char")
        return imageView
    }()
    
    let elementIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "default_elem")
        return imageView
    }()
    
    let specializationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "default_spec")
        return imageView
    }()
    
    let characterName: UILabel = {
        let label = UILabel()
        // ... настройки для label (шрифт, цвет и т. д.)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            configCellLayout()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configCellLayout() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(cellUIView)
        cellUIView.translatesAutoresizingMaskIntoConstraints = false

        cellUIView.addSubview(characterIcon)
        cellUIView.addSubview(characterName)
        cellUIView.addSubview(elementIcon)
        cellUIView.addSubview(specializationIcon)


        NSLayoutConstraint.activate([
            // 1. Отступы для cellUIView
            cellUIView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellUIView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            cellUIView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellUIView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            // 2. Элементы по центру
            characterIcon.centerYAnchor.constraint(equalTo: cellUIView.centerYAnchor),
            characterName.centerYAnchor.constraint(equalTo: cellUIView.centerYAnchor),
            elementIcon.centerYAnchor.constraint(equalTo: cellUIView.centerYAnchor),
            specializationIcon.centerYAnchor.constraint(equalTo: cellUIView.centerYAnchor),

            // 3. Размещение элементов в линию с равными промежутками
            characterIcon.leadingAnchor.constraint(equalTo: cellUIView.leadingAnchor, constant: 16),
            characterIcon.trailingAnchor.constraint(equalTo: characterName.leadingAnchor, constant: -16),
            characterName.trailingAnchor.constraint(equalTo: elementIcon.leadingAnchor, constant: -16),
            elementIcon.trailingAnchor.constraint(equalTo: specializationIcon.leadingAnchor, constant: -16),
            specializationIcon.trailingAnchor.constraint(equalTo: cellUIView.trailingAnchor, constant: -16),

            // Предполагается, что у каждого из элементов есть фиксированная ширина (замените на свои значения)
            characterIcon.widthAnchor.constraint(equalToConstant: 60),
            characterIcon.heightAnchor.constraint(equalToConstant: 60),// Пример
            characterName.widthAnchor.constraint(equalToConstant: 100), // Пример
            elementIcon.widthAnchor.constraint(equalToConstant: 60),
            elementIcon.heightAnchor.constraint(equalToConstant: 60),// Пример
            specializationIcon.widthAnchor.constraint(equalToConstant: 60),
            specializationIcon.heightAnchor.constraint(equalToConstant: 60)// Пример
        ])
    }
    
    //ОСТАНОВИЛСЯ ТУТ + Смотри в ЧАТ ГПТ)
    func configure(with character: Character) {
        characterName.text = character.name
        
        characterIcon.sd_setImage(with: URL(string: character.iconImageURL), placeholderImage: UIImage(named: "default_char"))
        elementIcon.sd_setImage(with: URL(string: character.elementURL), placeholderImage: UIImage(named: "default_elem"))
        specializationIcon.sd_setImage(with: URL(string: character.pathURL), placeholderImage: UIImage(named: "default_spec"))
        [characterIcon, elementIcon, specializationIcon, cellUIView
        ].forEach {
            $0.layer.cornerRadius = 30
        }
        [characterIcon, elementIcon, specializationIcon
        ].forEach {
            $0.clipsToBounds = true
        }
        
        cellUIView.backgroundColor = .white
//        character.elementType.color
    }
    
}
