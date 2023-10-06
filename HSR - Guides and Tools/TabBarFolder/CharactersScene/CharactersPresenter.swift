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

final class CharacterPresenter {
    
    weak var view: CharactersView?
    let firebaseManager: FirebaseManager
    
    var characters: [Character] = []
    let tierOrder: [String: Int] = ["S+": 0, "S": 1, "A": 2, "B": 3, "C": 4]
    
    init(view: CharactersView) {
        self.view = view
        self.firebaseManager = FirebaseManager()
    }
}

extension CharacterPresenter: CharacterPresenterProtocol {
    func viewDidLoad() {
        firebaseManager.fetchCharacters { [weak self] (loadedCharacters) in
            self?.characters = loadedCharacters.sorted {
                (self?.tierOrder[$0.basicInfo?.tier ?? ""] ?? 100) < (self?.tierOrder[$1.basicInfo?.tier ?? ""] ?? 100)
            }
            DispatchQueue.main.async {
                self?.view?.reloadData()
            }
        }
    }
    
    func numberOfRowsInsSection() -> Int {
        return characters.count
    }
    
    func characterAtIndexPath(_ indexPath: IndexPath) -> Character {
        return characters[indexPath.row]
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        let selectedCharacter = characters[indexPath.row]
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
        
    }
    
    private func sortByName() {
        self.characters.sort { $0.name < $1.name }
        view?.reloadData()
    }
    
    private func sortByElement() {
        self.characters.sort { $0.elementURL > $1.elementURL}
        view?.reloadData()
    }
    
    private func sortBySpec() {
        self.characters.sort { $0.pathURL > $1.pathURL }
        view?.reloadData()
    }
    
    private func sortByTier() {
        self.characters.sort { 
            (tierOrder[$0.basicInfo?.tier ?? ""] ?? 100) < (tierOrder[$1.basicInfo?.tier ?? ""] ?? 100)
        }
        view?.reloadData()
    }
    
    
    
}


