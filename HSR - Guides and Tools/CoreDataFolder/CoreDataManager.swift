//
//  CoreDataManager.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 30.10.2023.
//   Функции для основных операций с данными(CRUD)

import Foundation
import CoreData

class CoreDataManager {
    let context = CoreDataStack.shared.context
    
    // - Проверка на наличие персонажа
    func characterExists(withId id: String) -> Bool {
        let fetchRequest: NSFetchRequest<CharacterCoreData> = CharacterCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            return !(results.isEmpty)
        } catch {
            print("Ошибка при выполеннии fetch-запроса: \(error)")
            return false
        }
        
    }
    
    // - создание нового персонажа
    
    func createCharacter(from character: Character) -> CharacterCoreData {
        let characterCD = CharacterCoreData(context: context)
        
        characterCD.id = character.id
        
        characterCD.isFavorite = false
        
        characterCD.name = character.name
        
        characterCD.iconImageURL = character.iconImageURL
        
        //Рефликсия по признаку "is"
        let mirror = Mirror(reflecting: characterCD)
        for child in mirror.children {
            if child.label?.starts(with: "is") == true, let property = child.label {
                characterCD.setValue(false, forKey: property)
            }
        }
        
        return characterCD
        
    }
    
    // - сохранение изменений в Контекст
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("не удалось сохранить контекст")
        }
    }
    
    func saveCharacter(character: Character) {
        if !characterExists(withId: character.id ) {
            let _ = createCharacter(from: character)
            saveContext()
            print("\(character.name) - ПЕРСОНАЖ СОХРАНЕН")
        } else {
            print("\(character.name) уже существует в CoreData")
        }
    }
    
}
