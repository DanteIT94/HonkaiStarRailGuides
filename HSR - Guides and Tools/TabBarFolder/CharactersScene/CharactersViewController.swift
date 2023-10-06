//
//  CharactersViewController.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 16.08.2023.
//

import UIKit

protocol CharactersView: AnyObject {
    func reloadData()
    func present(_ alert: UIAlertController, animated: Bool)
    func presentCharacterGuideVC(character: Character)
}

class CharactersViewController: UIViewController {
    
    //MARK: - Private Properties
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgroundImage")
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
    
    var presenter: CharacterPresenterProtocol?
    private var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteDayNight
        presenter = CharacterPresenter(view: self)
        configureNavigationBar()
        configureCharacterTableView()
        presenter?.viewDidLoad()

    }
    
    //MARK: -Private Methods
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .whiteDayNight
        
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .done, target: self, action: #selector(sortButtonTapped))
        sortButton.tintColor = .blackDayNight
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(filterButtonTapped))
        filterButton.tintColor = .blackDayNight
        
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(scrollMenuButtonTapped))
        leftButton.tintColor = .blackDayNight
        
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItems = [sortButton, filterButton]

        let titleLabel = UILabel()
        titleLabel.text = "Персонажи"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        titleLabel.textColor = .blackDayNight
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        
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
    
    @objc private func sortButtonTapped() {
        presenter?.sortButtonTapped()
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
        navigationController?.pushViewController(characterVC, animated: true)
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


