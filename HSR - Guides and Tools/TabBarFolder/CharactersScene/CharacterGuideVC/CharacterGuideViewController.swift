//
//  CharacterGuideViewController.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 19.08.2023.
//

import UIKit
import SDWebImage

final class CharacterGuideVC: UIViewController {
    
    //Этап 1 - ScrollView
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let backgroundView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Этап 2 - Создаем все небходимые view для отобажения
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton_image"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(closeCurrentVC), for: .touchUpInside)
        return button
    }()
    ///Имя персонажа
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Персонаж"
        return label
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "fullImage_default")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    ///Окно состояния персонажа на текущую версию
    private var characterVersionState: VerticalLabelsStackView = {
        let charStackView = VerticalLabelsStackView(labelsText: ["Тир (Патч: N/A)", "N/A", "Роль в команде", "N/A", "Редкость", "N/A"])
        charStackView.translatesAutoresizingMaskIntoConstraints = false
        return charStackView
    }()
    
    private var currentCharacter: Character?
    
    init(character: Character) {
        self.currentCharacter = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configLayout()
        loadData()
    }
    
    private func configLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(characterNameLabel)
        backgroundView.addSubview(characterImageView)
        backgroundView.addSubview(characterVersionState)
        view.addSubview(backButton)

        
        NSLayoutConstraint.activate([
            //Слой ScrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: characterImageView.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            //Слой UI-компонентов
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            characterNameLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 30),
            characterNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            characterImageView.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 8),
            characterImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            characterImageView.widthAnchor.constraint(equalToConstant: 150),
            characterImageView.heightAnchor.constraint(equalToConstant: 200),
            
            characterVersionState.topAnchor.constraint(equalTo: characterImageView.topAnchor),
            characterVersionState.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            characterVersionState.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            characterVersionState.bottomAnchor.constraint(equalTo: characterImageView.bottomAnchor)
        ])
    }
    
    ///Метод для получения данных о персонаже
    private func loadData() {
        self.characterNameLabel.text = currentCharacter?.name
        if let URLString = currentCharacter?.fullImageURL, let url = URL(string: URLString) {
            self.characterImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "main_logo"))
        }
        
        let newInfoData = [
            "Тир (Патч: \(currentCharacter?.basicInfo?.gamePatch ?? "N/A"))",
            "\(currentCharacter?.basicInfo?.tier ?? "N/A")",
            "Роль в команде:",
            "\(currentCharacter?.basicInfo?.role ?? "N/A")",
            "Редкость: ",
            "\(currentCharacter?.basicInfo?.rarity ?? "N/A")"
        ]
        characterVersionState.updateLabels(with: newInfoData)
    }
    
    @objc private func closeCurrentVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        print("Назад на экран выбора персонажа")
    }
}
