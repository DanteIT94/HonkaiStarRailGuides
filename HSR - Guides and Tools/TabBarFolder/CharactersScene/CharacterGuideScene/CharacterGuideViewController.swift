//
//  CharacterGuideViewController.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 19.08.2023.
//

import UIKit
import SDWebImage
import ProgressHUD

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
    private var statsView: StatsView!
    
    private var currentCharacter: Character?
    var appMetric = AppMetrics()
    private let appMetricScreenName = "CharacterGuideVC"
    
    init(character: Character) {
        self.currentCharacter = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteDayNight
        appMetric.reportEvent(screen: appMetricScreenName, event: .open, item: nil)
        configureNavigationBar()
        configLayout()
        loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        appMetric.reportEvent(screen: appMetricScreenName, event: .close, item: nil)
    }
    
    //MARK: - Private Methods
    
    private func configureNavigationBar() {
        navigationItem.title = "\(currentCharacter?.name ?? "Персонаж")"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(closeCharacterVC))
        backButton.tintColor = .blackDayNight
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down.on.square"), style: .plain, target: self, action: #selector(downloadGuidePicture))
        rightButton.tintColor = .blackDayNight
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = rightButton
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
            "Роль в команде",
            "\(currentCharacter?.basicInfo?.role ?? "N/A")",
            "Редкость",
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
        
        statsView = StatsView()
        
        [weaponsView, relicsView, planarsView, statsView].forEach {
            $0?.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.addSubview($0!)
        }
        
        let mainComments = [
            currentCharacter?.stats?.mainStats?.body?.value ?? "",
            currentCharacter?.stats?.mainStats?.foot?.value ?? "",
            currentCharacter?.stats?.mainStats?.sphere?.value ?? "",
            currentCharacter?.stats?.mainStats?.chain?.value ?? ""]
        
        let additionalComment = currentCharacter?.stats?.additionalStats?.value ?? ""
        
        statsView.updateComments(mainStatsComment: mainComments, additionalStatsComment: additionalComment)
        
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
            
            statsView.topAnchor.constraint(equalTo: planarsView.bottomAnchor, constant: 16),
            statsView.leadingAnchor.constraint(equalTo: weaponsView.leadingAnchor),
            statsView.trailingAnchor.constraint(equalTo: weaponsView.trailingAnchor),
            statsView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -16)
        ])
    }
    
    //Блок кода для подсчета когда можно показать аллерт
    private func incrementCloseCounter() {
        let closeCounter = UserDefaults.standard.integer(forKey: "closeCounter") + 1
        UserDefaults.standard.set(closeCounter, forKey: "closeCounter")
    }
    
    private func shouldShowAlert() -> Bool {
        let closeCounter = UserDefaults.standard.integer(forKey: "closeCounter")
        return closeCounter % 8 == 0
    }
    
    //MARK: - OBJC Methods
    @objc private func downloadGuidePicture() {
        appMetric.reportEvent(screen: appMetricScreenName, event: .click, item: .imageGuideButtonTap)
        let alert = UIAlertController(title: "Скачать дополнительный гайд в виде картинки?", message: "P.S.: Данные могут отличаться ввиду разных взглядов авторов", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Да, скачать", style: .default, handler: { _ in
            ProgressHUD.show("Загрузка...")
            
            if let stringURL = self.currentCharacter?.guideImageURL, let imageURL = URL(string: stringURL) {
                SDWebImageManager.shared.loadImage(with: imageURL,
                                                   options: .highPriority,
                                                   progress: nil) { image, data, error, cacheType, success, url in
                    ProgressHUD.dismiss()
                    if let imageToSave = image {
                        UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(self.imageSavedSuccessfully(_:didFinishSavingWithError:contextInfo:)), nil)
                    } else if let error = error {
                        print("\(error)")
                    }
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func imageSavedSuccessfully(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // Не удалось сохранить изображение
            let ac = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ОК", style: .default))
            present(ac, animated: true)
        } else {
            // Успешно сохранено
            let ac = UIAlertController(title: "Сохранено", message: "Ваше изображение было сохранено в фотоальбом.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
                // Открываем приложение "Фото"
                if let url = URL(string: "photos-redirect://") {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }))
            present(ac, animated: true)
        }
    }
    
    
    @objc private func closeCharacterVC() {
        incrementCloseCounter()
        
        if shouldShowAlert() {
            UserDefaults.standard.set(0, forKey: "closeCounter")
            NotificationCenter.default.post(name: .showReviewAlert, object: nil)
        }
        
        navigationController?.popViewController(animated: true)
        print("Назад на экран выбора персонажа")
    }
}


