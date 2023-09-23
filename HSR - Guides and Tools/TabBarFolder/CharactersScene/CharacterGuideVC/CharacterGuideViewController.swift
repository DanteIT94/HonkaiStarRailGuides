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
        let charStackView = VerticalLabelsStackView(labelsText: ["Тир (Патч: N/A)",
                                                                 "N/A",
                                                                 "Роль в команде",
                                                                 "N/A",
                                                                 "Редкость",
                                                                 "N/A"])
        charStackView.translatesAutoresizingMaskIntoConstraints = false
        return charStackView
    }()
    
    private var weaponsView: TopItemsView!
    private var relicsView: TopItemsView!
    private var planarsView: TopItemsView!
    
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
        configureNavigationBar()
        configLayout()
        loadData()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "\(currentCharacter?.name ?? "Персонаж")"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(closeCharacterVC))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func configLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        [characterImageView, characterVersionState].forEach {
            backgroundView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            //Слой ScrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            backgroundView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            characterImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 8),
            characterImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            characterImageView.widthAnchor.constraint(equalToConstant: 150),
            characterImageView.heightAnchor.constraint(equalToConstant: 200),
            
            characterVersionState.topAnchor.constraint(equalTo: characterImageView.topAnchor),
            characterVersionState.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            characterVersionState.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            characterVersionState.bottomAnchor.constraint(equalTo: characterImageView.bottomAnchor),
        ])
    }
    
    ///Метод для получения данных о персонаже
    private func loadData() {
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
        
        weaponsView = TopItemsView(items: [
            currentCharacter?.weapons?.firstWeapon,
            currentCharacter?.weapons?.secondWeapon,
            currentCharacter?.weapons?.thirdWeapon
        ].compactMap { $0 },
                                   header: "Топ 3 Конуса")
        relicsView = TopItemsView(items: [
            currentCharacter?.relics?.firstRelic,
            currentCharacter?.relics?.secondRelic,
            currentCharacter?.relics?.thirdRelic
        ].compactMap { $0 },
                                  header: "Топ 3 комплекта реликвий")
        planarsView = TopItemsView(items: [
            currentCharacter?.planars?.firstPlanar,
            currentCharacter?.planars?.secondPlanar
        ].compactMap { $0 },
                                   header: "Toп Планарных украшений")
        
        [weaponsView, relicsView, planarsView].forEach {
            $0?.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.addSubview($0!)
        }
        NSLayoutConstraint.activate([
            weaponsView.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 16),
            weaponsView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 8),
            weaponsView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -8),
            
            relicsView.topAnchor.constraint(equalTo: weaponsView.bottomAnchor, constant: 16),
            relicsView.leadingAnchor.constraint(equalTo: weaponsView.leadingAnchor),
            relicsView.trailingAnchor.constraint(equalTo: weaponsView.trailingAnchor),
            
            planarsView.topAnchor.constraint(equalTo: relicsView.bottomAnchor, constant: 16),
            planarsView.leadingAnchor.constraint(equalTo: weaponsView.leadingAnchor),
            planarsView.trailingAnchor.constraint(equalTo: weaponsView.trailingAnchor),
            planarsView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -16)
        ])
    }
        
    
    @objc private func closeCharacterVC() {
        navigationController?.popViewController(animated: true)
        print("Назад на экран выбора персонажа")
    }
}
