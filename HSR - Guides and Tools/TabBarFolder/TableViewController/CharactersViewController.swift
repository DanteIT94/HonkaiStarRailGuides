//
//  CharactersViewController.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 16.08.2023.
//

import UIKit
import FirebaseStorage


class CharactesViewController: UIViewController {
    
    //MARK: - Private Properties
    
    private let charactersTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 100
        return tableView
    }()
    
    
    let firebaseManager = FirebaseManager()
    private var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureCharacterTableView()
        firebaseManager.fetchCharacters { [weak self] (loadedCharacters) in
            self?.characters = loadedCharacters
            DispatchQueue.main.async {
                self?.charactersTableView.reloadData()
            }
        }
        
    }
    
    //MARK: -Private Methods
    private func configureNavigationBar() {
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(scrollMenuButtonTapped))
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "moon.circle"), style: .done, target: self, action: #selector(scrollMenuButtonTapped))
        leftButton.tintColor = .black
        rightButton.tintColor = .black
        
        let separatorView = UIView(frame: CGRect(x: 0, y: navigationController?.navigationBar.frame.height ?? 0 - 1, width: UIScreen.main.bounds.width, height: 1))
        separatorView.backgroundColor = .gray
        navigationController?.navigationBar.addSubview(separatorView)
        
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        let titleLabel = UILabel()
        titleLabel.text = "Персонажи"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
    
    
    private func configureCharacterTableView() {
        view.addSubview(charactersTableView)
        
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        
        charactersTableView.register(CharacterCell.self, forCellReuseIdentifier: "CharacterCell")
        charactersTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0 )
        
        NSLayoutConstraint.activate([
            charactersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            charactersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            charactersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            charactersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    //MARK: - Methods
//    private func loadCharacterIcon(from url: URL, into cell: CharacterCell) {
//        let storageReference = Storage.storage().reference(forURL: url.absoluteString)
//
//        storageReference.getData(maxSize: 1 * 1024 * 1024) { [weak self] data, error in
//            guard let imageData = data, error == nil else {
//                // Handle the error
//                return
//            }
//
//            DispatchQueue.main.async {
//                cell.characterIconImageView.image = UIImage(data: imageData)
//
//                // Increase the downloadedIconCount after successful image download
//                self?.downloadedIconCount += 1
//            }
//        }
//    }
    
    
    //MARK: -@OBJC Methods
    @objc private func scrollMenuButtonTapped() {
        
    }
    
    
}

//MARK:  -UITableViewDataSource
extension CharactesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharacterCell else {
            return UITableViewCell()
        }
        let character = characters[indexPath.row]
        cell.configure(with: character)
        
        return cell
    }
    
    
}

//MARK:  -UITableViewDelegate
extension CharactesViewController: UITableViewDelegate {
    
    
}



//var timer: Timer?
//var progressLayer: CAShapeLayer!
//
//// Создаем циферблат
//let center = view.center
//let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
//
//// Создаем фоновый слой циферблата
//let trackLayer = CAShapeLayer()
//trackLayer.path = circularPath.cgPath
//trackLayer.strokeColor = UIColor.lightGray.cgColor
//trackLayer.lineWidth = 10
//trackLayer.fillColor = UIColor.clear.cgColor
//view.layer.addSublayer(trackLayer)
//
//// Создаем слой прогресса циферблата
//progressLayer = CAShapeLayer()
//progressLayer.path = circularPath.cgPath
//progressLayer.strokeColor = UIColor.red.cgColor
//progressLayer.lineWidth = 10
//progressLayer.fillColor = UIColor.clear.cgColor
//progressLayer.strokeEnd = 0 // Устанавливаем начальное значение прогресса
//progressLayer.lineCap = .round
//view.layer.addSublayer(progressLayer)
//
//// Добавляем кнопку старта
//let startButton = UIButton(type: .system)
//startButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
//startButton.center = CGPoint(x: view.frame.midX, y: view.frame.maxY - 100)
//startButton.setTitle("Start", for: .normal)
//startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
//view.addSubview(startButton)
//
//@objc func startTimer() {
//    // Инициализируем и запускаем таймер
//    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
//}
//
//@objc func updateProgress() {
//    // Увеличиваем значение прогресса на каждом вызове таймера
//    progressLayer.strokeEnd += 1.0 / 60.0 // Предполагаем 60 FPS
//    if progressLayer.strokeEnd >= 1.0 {
//        // Таймер завершен, останавливаем его
//        timer?.invalidate()
//    }
//}
