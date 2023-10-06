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

extension Character {
    var elementType: Element {
        switch elementURL {
        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Elements%2FType_Fire.jpeg?alt=media&token=824c5002-e2a8-4162-a152-e3c241e7a5be":
            return .fire
        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Elements%2FType_Ice.jpeg?alt=media&token=97c23b23-41c3-4aa1-88c6-48b325a29242":
            return .ice
        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Elements%2FType_Imaginary.jpeg?alt=media&token=bc045ed2-c770-4876-9cbf-8cdae4fe0385":
            return .imaginary
        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Elements%2FType_Lightning.jpeg?alt=media&token=4b5e755e-bc1e-4c57-98ac-32190eb390d9":
            return .lightning
        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Elements%2FType_Quantum.jpeg?alt=media&token=07208e01-28fa-45de-b1b5-7af1ea3ed38c":
            return .quantum
        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Elements%2FType_Wind.jpeg?alt=media&token=4dc817b6-f825-4aa0-ad79-15c00a3aa394":
            return .wind
        default:
            return .physical // или любой другой стандартный элемент, если URL не совпадает
        }
    }
}



