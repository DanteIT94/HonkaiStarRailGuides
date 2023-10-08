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

    init() {
        databaseReference = Database.database().reference()
    }
    
    func fetchCharacters(progress: @escaping (Float) -> Void, completion: @escaping ([Character]) -> Void) {
        databaseReference.child("characters").observe(.value) { (snapshot) in
            var loadedCharacters: [Character] = []
            let totalChildren = Float(snapshot.childrenCount)
            var currentProgress: Float = 0.0
            
            for child in snapshot.children {
                currentProgress += 1.0
                progress(currentProgress/totalChildren)
                
                if let childSnapshot = child as? DataSnapshot,
                   let dict = childSnapshot.value as? [String: Any] {
                    
                    let name = dict["name"] as? String ?? ""
                    let elementURL = dict["element"] as? String ?? ""
                    let fullImageURL = dict["fullImage"] as? String
                    let iconImageURL = dict["iconImage"] as? String ?? ""
                    let pathURL = dict["path"] as? String ?? ""
                    let guideImageURL = dict["guideImage"] as? String ?? ""
                    
                    let basicInfoDict = dict["basicInfo"] as? [String: String] ?? [:]
                    let planarsDict = dict["planars"] as? [String: [String: String]] ?? [:]
                    let relicsDict = dict["relics"] as? [String: [String: String]] ?? [:]
                    let statsDict = dict["stats"] as? [String: Any] ?? [:]
                    let weaponsDict = dict["weapons"] as? [String: [String: String]] ?? [:]
                    
                    let basicInfo = BasicInfo(
                        gamePatch: basicInfoDict["gamePatch"] ?? "",
                        rarity: basicInfoDict["rarity"] ?? "",
                        role: basicInfoDict["role"] ?? "",
                        tier: basicInfoDict["tier"] ?? ""
                    )
                    
                    let firstPlanar = Item.from(dict: planarsDict["firstPlanar"] ?? [:])
                    let secondPlanar = Item.from(dict: planarsDict["secondPlanar"] ?? [:])
                    let planars = Planars(firstPlanar: firstPlanar, secondPlanar: secondPlanar)
                    
                    let firstRelic = Item.from(dict: relicsDict["firstRelic"] ?? [:])
                    let secondRelic = Item.from(dict: relicsDict["secondRelic"] ?? [:])
                    let thirdRelic = Item.from(dict: relicsDict["thirdRelic"] ?? [:])
                    let relics = Relics(firstRelic: firstRelic, secondRelic: secondRelic, thirdRelic: thirdRelic)
                    
                    let mainStatsDict = statsDict["mainStats"] as? [String: [String: String]] ?? [:]
                    let mainStats = MainStats.from(dict: mainStatsDict)
                    
                    let additionalStatsDict = statsDict["additionalStats"] as? [String: String] ?? [:]
                    let additionalStats = AdditionalStats(value: additionalStatsDict["value"] ?? "")
                    let stats = Stats(additionalStats: additionalStats, mainStats: mainStats)
                    
                    let firstWeapon = Item.from(dict: weaponsDict["firstWeapon"] ?? [:])
                    let secondWeapon = Item.from(dict: weaponsDict["secondWeapon"] ?? [:])
                    let thirdWeapon = Item.from(dict: weaponsDict["thirdWeapon"] ?? [:])
                    let weapons = Weapons(firstWeapon: firstWeapon, secondWeapon: secondWeapon, thirdWeapon: thirdWeapon)
                    
                    let character = Character(
                        id: childSnapshot.key,
                        name: name,
                        elementURL: elementURL,
                        fullImageURL: fullImageURL,
                        iconImageURL: iconImageURL,
                        pathURL: pathURL,
                        guideImageURL: guideImageURL,
                        planars: planars,
                        relics: relics,
                        stats: stats,
                        weapons: weapons,
                        basicInfo: basicInfo
                    )
                    
                    loadedCharacters.append(character)
                }
            }
            completion(loadedCharacters)
        }
    }

}

