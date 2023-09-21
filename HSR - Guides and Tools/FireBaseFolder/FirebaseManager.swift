//
//  APIManager.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 16.08.2023.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase
import UIKit
import Firebase

class FirebaseManager {
    var databaseReference: DatabaseReference!
    var characters: [Character] = []

    init() {
        databaseReference = Database.database().reference()
    }

    func fetchCharacters(completion: @escaping ([Character]) -> Void) {
        databaseReference.child("characters").observe(.value) { (snapshot) in
            var loadedCharacters: [Character] = []
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let dict = childSnapshot.value as? [String: Any],
                   let name = dict["name"] as? String,
                   let elementURL = dict["element"] as? String,
                   let iconImageURL = dict["iconImage"] as? String,
                   let pathURL = dict["path"] as? String {
                    
                    let fullImageURL = dict["fullImage"] as? String
                    
                    let character = Character(id: childSnapshot.key,
                                              name: name,
                                              elementURL: elementURL,
                                              fullImageURL: fullImageURL,
                                              iconImageURL: iconImageURL,
                                              pathURL: pathURL)
                    loadedCharacters.append(character)
                }
            }

            self.characters = loadedCharacters
            completion(loadedCharacters)
        }
    }
}

