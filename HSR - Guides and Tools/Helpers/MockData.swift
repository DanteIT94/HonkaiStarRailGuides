//
//  MockData.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 28.09.2023.
//

import Foundation

// Здесь предполагается, что у тебя уже есть все основные структуры (Character, Item, Planars, etc.)

struct MockData {
    
    static let shared = MockData()
    
    // Создание моковых данных для Item
    let mockItem = Item(comment: "Mock Comment", description: "Mock Description", image: "Mock Image URL", name: "Mock Item")
    
    // Создание моковых данных для Planars, Relics и Weapons
    let mockPlanars: Planars
    let mockRelics: Relics
    let mockWeapons: Weapons
    
    // Создание моковых данных для Stats
    let mockStat: Stat
    let mockMainStats: MainStats
    let mockAdditionalStats: AdditionalStats
    let mockStats: Stats
    
    // Создание моковых данных для BasicInfo
    let mockBasicInfo: BasicInfo
    
    // Создание моковых данных для Character
    let mockCharacter: Character
    
    private init() {
        self.mockPlanars = Planars(firstPlanar: mockItem, secondPlanar: mockItem)
        self.mockRelics = Relics(firstRelic: mockItem, secondRelic: mockItem, thirdRelic: mockItem)
        self.mockWeapons = Weapons(firstWeapon: mockItem, secondWeapon: mockItem, thirdWeapon: mockItem)
        
        self.mockStat = Stat(image: "Mock Stat Image", value: "Mock Stat Value")
        self.mockMainStats = MainStats(body: mockStat, chain: mockStat, foot: mockStat, sphere: mockStat)
        self.mockAdditionalStats = AdditionalStats(value: "Mock Additional Value")
        self.mockStats = Stats(additionalStats: mockAdditionalStats, mainStats: mockMainStats)
        
        self.mockBasicInfo = BasicInfo(gamePatch: "Mock Game Patch", rarity: "Mock Rarity", role: "Mock Role", tier: "Mock Tier")
        
        self.mockCharacter = Character(id: "Mock ID", name: "Mock Character", elementURL: "Mock Element URL", fullImageURL: "Mock Full Image URL", iconImageURL: "Mock Icon Image URL", pathURL: "Mock Path URL", planars: mockPlanars, relics: mockRelics, stats: mockStats, weapons: mockWeapons, basicInfo: mockBasicInfo)
    }
}
