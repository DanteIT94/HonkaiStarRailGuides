//
//  CharactersViewController.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 16.08.2023.
//

import UIKit
import FirebaseStorage

protocol CharactersView: AnyObject {
    func reloadData()
    func present(_ alert: UIAlertController, animated: Bool)
    func presentCharacterGuideVC(character: Character)
}


class CharactersViewController: UIViewController {
    
    //MARK: - Private Properties
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "1581410453_2")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let charactersTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 100
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
//    let firebaseManager = FirebaseManager()
    var presenter: CharacterPresenterProtocol?
    private var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CharacterPresenter(view: self)
        configureNavigationBar()
        configureCharacterTableView()
        presenter?.viewDidLoad()
//        firebaseManager.fetchCharacters { [weak self] (loadedCharacters) in
//            self?.characters = loadedCharacters
//            DispatchQueue.main.async {
//                self?.charactersTableView.reloadData()
//            }
//        }
    }
    
    //MARK: -Private Methods
    private func configureNavigationBar() {
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(scrollMenuButtonTapped))
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .done, target: self, action: #selector(filterButtonTapped))
        leftButton.tintColor = .black
        rightButton.tintColor = .black
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        let titleLabel = UILabel()
        titleLabel.text = "Персонажи"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        
        let separatorView = UIView(frame: CGRect(x: 0, y: navigationController?.navigationBar.frame.height ?? 0 - 1, width: UIScreen.main.bounds.width, height: 1))
        separatorView.backgroundColor = .gray
        navigationController?.navigationBar.addSubview(separatorView)
    }
    
    
    private func configureCharacterTableView() {
        view.insertSubview(backgroundImage, at: 0)
        view.addSubview(charactersTableView)
        
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        
        charactersTableView.register(CharacterCell.self, forCellReuseIdentifier: "CharacterCell")
        charactersTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0 )
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            charactersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            charactersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            charactersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            charactersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    //MARK: - Methods
    
    
    //MARK: -@OBJC Methods
    @objc private func scrollMenuButtonTapped() {
        
    }
    
    @objc private func filterButtonTapped() {
        presenter?.filterButtonTapped()
    }
}

extension CharactersViewController: CharactersView {
    func reloadData() {
        charactersTableView.reloadData()
    }
    
    func present(_ alert: UIAlertController, animated: Bool) {
        self.present(alert, animated: animated, completion: nil)
    }
    
    func presentCharacterGuideVC(character: Character) {
        let characterVC = CharacterGuideVC(character: character)
        characterVC.modalPresentationStyle = .fullScreen
        present(characterVC, animated: true)
    }
}


//MARK:  -UITableViewDataSource
extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInsSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharacterCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        if let character = presenter?.characterAtIndexPath(indexPath) {
                cell.configure(with: character)
        }
        print(characters)
        return cell
    }
    
    
}

//MARK:  -UITableViewDelegate
extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectRowAt(indexPath: indexPath)
    }
    
}
