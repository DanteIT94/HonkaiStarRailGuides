//
//  SortService.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 06.10.2023.
//

import Foundation

class SortService {
    let tierOrder: [String: Int] = ["S+": 0, "S": 1, "A": 2, "B": 3, "C": 4]
    
    func sortCharactersByName(_ characters: [Character]) -> [Character] {
        return characters.sorted { $0.name < $1.name}
    }
    
    func sortCharactesByElement(_ characters: [Character]) -> [Character] {
        return characters.sorted { $0.elementURL > $1.elementURL }
    }
    
    func sortCharactersBySpec(_ characters: [Character]) -> [Character] {
        return characters.sorted { $0.pathURL > $1.pathURL }
    }
    
    func sortCharacterByTier(_ characters: [Character]) -> [Character] {
        return characters.sorted {
            (tierOrder[$0.basicInfo?.tier ?? ""] ?? 100) < (tierOrder[$1.basicInfo?.tier ?? ""] ?? 100)
        }
    }
    
}
