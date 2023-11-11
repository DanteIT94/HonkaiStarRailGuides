//
//  CoreDataStack.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 30.10.2023.
//  Центр управления CoreData. В нем создан NSPersistentContainer, контекст для работы с данными и функция для сохранения изменений.

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CharacterProgressModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("\(error.localizedDescription)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror =  error as NSError
                fatalError("Ошибка сохранения: \(nserror.localizedDescription)")
            }
        }
    }
}
