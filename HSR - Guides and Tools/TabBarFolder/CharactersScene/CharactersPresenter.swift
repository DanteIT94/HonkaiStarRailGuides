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
    func filterButtonTapped()
}

final class CharacterPresenter {
    
    weak var view: CharactersView?
    var characters: [Character] = []
    let firebaseManager: FirebaseManager
    
    init(view: CharactersView) {
        self.view = view
        self.firebaseManager = FirebaseManager()
    }
}

extension CharacterPresenter: CharacterPresenterProtocol {
    func viewDidLoad() {
        firebaseManager.fetchCharacters { [weak self] (loadedCharacters) in
            self?.characters = loadedCharacters
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
    
    func filterButtonTapped() {
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
        
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
        
        view?.present(alert, animated: true)
    }
    
    private func sortByName() {
        self.characters.sort { $0.name > $1.name }
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
    
}


