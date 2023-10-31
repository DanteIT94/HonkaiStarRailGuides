//
//  CharactersPresenter.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 21.09.2023.
//

import Foundation
import UIKit

protocol CharacterPresenterProtocol {
    func viewDidLoad()
    func numberOfRowsInsSection() -> Int
    func characterAtIndexPath(_ indexPath: IndexPath) -> Character
    func didSelectRowAt(indexPath: IndexPath)
    func sortButtonTapped()
    func filterButtonTapped()
}

protocol ProgressDelegate: AnyObject {
    func didLoadCharacters()
//    func updateProgress(_ progress: Float)
}

final class CharacterPresenter {
    
    weak var view: CharactersView?
    weak var progressDelegate: ProgressDelegate?
    
    let firebaseManager: FirebaseManager
    let sortService: SortService
    let filterService: FilterService
    
    let coreDataManager: CoreDataManager
    
    var characters: [Character] = []
    let tierOrder: [String: Int] = ["S+": 0, "S": 1, "A": 2, "B": 3, "C": 4]
    
    //MARK: - Для фильтрации
    var filteredCharacter: [Character] = []
    var isFiltered: Bool = false
    
    init(view: CharactersView?) {
        self.view = view
        self.firebaseManager = FirebaseManager()
        self.filterService = FilterService()
        self.sortService = SortService()
        self.coreDataManager = CoreDataManager()
    }
}

extension CharacterPresenter: CharacterPresenterProtocol {
    func viewDidLoad() {
        firebaseManager.fetchCharacters(progress: { newProgress in
            NotificationCenter.default.post(name: NSNotification.Name("updateProgressBar"),
                                            object: nil,
                                            userInfo: ["progress": newProgress])
            }, completion: { [weak self] (loadedCharacters) in
            self?.characters = loadedCharacters.sorted {
                (self?.tierOrder[$0.basicInfo?.tier ?? ""] ?? 100) < (self?.tierOrder[$1.basicInfo?.tier ?? ""] ?? 100)
            }
                
            for character in self?.characters ?? [] {
                self?.coreDataManager.saveCharacter(character: character)
            }
                
            DispatchQueue.main.async {
                self?.view?.reloadData()
                self?.progressDelegate?.didLoadCharacters()
            }
        })
    }
    
    func numberOfRowsInsSection() -> Int {
        return isFiltered ? filteredCharacter.count : characters.count
    }
    
    func characterAtIndexPath(_ indexPath: IndexPath) -> Character {
        return isFiltered ? filteredCharacter[indexPath.row] : characters[indexPath.row]
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        let selectedCharacter = isFiltered ? filteredCharacter[indexPath.row] : characters[indexPath.row]
        view?.presentCharacterGuideVC(character: selectedCharacter)
    }
    
    func sortButtonTapped() {
        let alert = UIAlertController(title: "Сортировка по:", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Имя", style: .default, handler: {_ in
            self.sortByName()
        }))
        
        alert.addAction(UIAlertAction(title: "Элемент", style: .default, handler: {_ in
            self.sortByElement()
        }))
        
        alert.addAction(UIAlertAction(title: "Путь", style: .default, handler: {_ in
            self.sortBySpec()
        }))
        
        alert.addAction(UIAlertAction(title: "Тир", style: .default, handler: { _ in
            self.sortByTier()
        }))
        
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
        
        view?.present(alert, animated: true)
    }
    
    func filterButtonTapped() {
        let alert = UIAlertController(title: "Фильтрация по:", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Тир", style: .default, handler: { [weak self] _ in
            self?.showTierSelection()
        }))
        
        alert.addAction(UIAlertAction(title: "Элемент", style: .default, handler: { [weak self] _ in
            self?.showElementSelection()
        }))
        
        alert.addAction(UIAlertAction(title: "Путь", style: .default, handler: { [weak self] _ in
            self?.showPathSelection()
        }))
        
        alert.addAction(UIAlertAction(title: "Снять фильтр", style: .destructive, handler: { [weak self] _ in
            self?.isFiltered = false
            self?.view?.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
        self.view?.present(alert, animated: true)
    }
    
    //MARK: - Private Methods
    private func sortByName() {
        self.characters = sortService.sortCharactersByName(self.characters)
        view?.reloadData()
    }
    
    private func sortByElement() {
        self.characters = sortService.sortCharactesByElement(self.characters)
        view?.reloadData()
    }
    
    private func sortBySpec() {
        self.characters = sortService.sortCharactersBySpec(self.characters)
        view?.reloadData()
    }
    
    private func sortByTier() {
        self.characters = sortService.sortCharacterByTier(self.characters)
        view?.reloadData()
    }
    
    private func showTierSelection() {
        let tierAlert = UIAlertController(title: "Выберите Тир", message: nil, preferredStyle: .actionSheet)
        let tiers = ["S+", "S", "A", "B", "C"]
        
        for tier in tiers {
            tierAlert.addAction(UIAlertAction(title: tier, style: .default, handler: { [weak self] _ in
                self?.filterByTier(tier)
            }))
        }
        tierAlert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        view?.present(tierAlert, animated: true)
    }
    
    private func filterByTier(_ tier: String) {
        isFiltered = true
        filteredCharacter = filterService.filterCharacterByTier(characters, tier: tier)
        view?.reloadData()
    }
    
    private func showElementSelection() {
        let elementAlert = UIAlertController(title: "Выбери Элемент", message: nil, preferredStyle: .actionSheet)
        let elements: [Element: String] = [
            .fire: "Огонь",
            .ice: "Лед",
            .imaginary: "Мнимый",
            .lightning: "Электро",
            .physical: "Физический",
            .quantum: "Квантовый",
            .wind: "Ветряной"
        ]
        
        for (element, displayName) in elements {
            elementAlert.addAction(UIAlertAction(title: displayName, style: .default, handler: { [weak self] _ in
                self?.filterByElement(element)
            }))
        }
        elementAlert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            
        view?.present(elementAlert, animated: true)
    }
    
    private func showPathSelection() {
        let pathAlert = UIAlertController(title: "Выбери Путь", message: nil, preferredStyle: .actionSheet)
        let paths: [Path] = [.abundance, .destruction, .erudition, .harmony, .hunt, .nihility, .preservation]
        
        for path in paths {
            pathAlert.addAction(UIAlertAction(title: path.description, style: .default, handler: { [weak self] _ in
                self?.filterByPath(path)
            }))
        }
        
        pathAlert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        view?.present(pathAlert, animated: true)
    }
    
    private func filterByElement(_ element: Element) {
        isFiltered = true
        filteredCharacter = filterService.filterCharacterByElement(characters, element: element)
        view?.reloadData()
    }
    
    private func filterByPath(_ path: Path) {
        isFiltered = true
        filteredCharacter = filterService.filterCharacterByPath(characters, path: path)
        view?.reloadData()
    }
    
}


