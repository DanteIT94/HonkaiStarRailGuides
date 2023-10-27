//
//  CoreDataModels.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 27.10.2023.
//

import Foundation
import CoreData

@objc(CharacterEntity)
public class CharacterEntity: NSManagedObject {
    
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var icon: Data?
    @NSManaged public var isBodyOk: Bool
    @NSManaged public var isChainOk: Bool
    @NSManaged public var isFeetOk: Bool
    @NSManaged public var isHandsOk: Bool
    @NSManaged public var isHeadOk: Bool
    @NSManaged public var isLevelMax: Bool
    @NSManaged public var isSphereOk: Bool
    @NSManaged public var isTraitMax: Bool
    @NSManaged public var isWeaponOk: Bool
    @NSManaged public var group: GroupEntity?
}

@objc(GroupEntity)
public class GroupEntity: NSManagedObject {
    @NSManaged public var characters: Set<CharacterEntity>
}

extension CharacterEntity {
    static var preview: CharacterEntity {
        let entity = CharacterEntity(context: PersistenceController.preview.container.viewContext)
        entity.name = "Test Name"
        entity.isLevelMax = false
        entity.isTraitMax = false
        entity.isBodyOk = false
        entity.isChainOk = false
        entity.isSphereOk = false
        entity.isHandsOk = true
        entity.isHeadOk = false
        entity.isFeetOk = true
        entity.isWeaponOk = false
        return entity
    }
}

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CharacterEntity")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

