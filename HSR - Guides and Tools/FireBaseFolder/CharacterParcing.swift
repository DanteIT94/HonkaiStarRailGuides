//
//  CharacterParcing.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 16.08.2023.
//

import Foundation
import UIKit

struct Character: Codable {
    var id: String?
    let name: String
    let elementURL: String
    let fullImageURL: String?
    let iconImageURL: String
    let pathURL: String
    let guideImageURL: String?
    let planars: Planars?
    let relics: Relics?
    let stats: Stats?
    let weapons: Weapons?
    let basicInfo: BasicInfo?
}

struct Planars: Codable {
    let firstPlanar: Item
    let secondPlanar: Item
}

struct Relics: Codable {
    let firstRelic: Item
    let secondRelic: Item
    let thirdRelic: Item
}

struct Weapons: Codable {
    let firstWeapon: Item
    let secondWeapon: Item
    let thirdWeapon: Item
}

struct Item: Codable {
    let comment: String
    let description: String
    let image: String
    let name: String
}

extension Item {
    static func from(dict: [String: String]) -> Item {
        return Item(
            comment: dict["comment"] ?? "",
            description: dict["description"] ?? "",
            image: dict["image"] ?? "",
            name: dict ["name"] ?? ""
        )
    }
}

struct Stats: Codable {
    let additionalStats: AdditionalStats?
    let mainStats: MainStats?
}

struct AdditionalStats: Codable {
    let value: String
}

struct MainStats: Codable {
    let body: Stat?
    let chain: Stat?
    let foot: Stat?
    let sphere: Stat?
}

extension MainStats {
    static func from(dict: [String : [String: String]]) -> MainStats {
        return MainStats(
            body: Stat.from(dict: dict["body"] ?? [:]),
            chain: Stat.from(dict: dict["chain"] ?? [:]),
            foot: Stat.from(dict: dict["foot"] ?? [:]),
            sphere: Stat.from(dict: dict["sphere"] ?? [:])
        )
    }
}

struct Stat: Codable {
    let image: String
    let value: String
}

extension Stat {
    static func from(dict: [String: String]) -> Stat {
        return Stat(image: dict["image"] ?? "",
                    value: dict["value"] ?? "")
    }
}

struct BasicInfo: Codable {
    let gamePatch: String
    let rarity: String
    let role: String
    let tier: String
}


enum Element {
    case fire, ice, lightning, imaginary, wind, physical, quantum
    var color: UIColor {
        switch self {
        case .fire: return .colorSection1!
        case .ice: return .colorSection8!
        case .lightning: return .colorSection17!
        case .wind: return .colorSection18!
        case .imaginary: return .colorSection19!
        case .physical: return .lightGray
        case .quantum: return .colorSection10!
        }
    }
}

enum Path: CustomStringConvertible {
    case destruction, hunt, erudition, harmony, nihility, preservation, abundance
    var description: String {
        switch self {
        case .destruction: return "Разрушение"
        case .hunt: return "Охота"
        case .erudition: return "Эрудиция"
        case .harmony: return "Гармония"
        case .nihility: return "Небытие"
        case .preservation: return "Сохрание"
        case .abundance: return "Изобилие"
        }
    }
}





