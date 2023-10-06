//
//  FilterService.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 06.10.2023.
//

import Foundation

class FilterService {
    
    func filterCharacterByTier(_ characters: [Character], tier: String) -> [Character] {
        return characters.filter { $0.basicInfo?.tier == tier}
    }
}
