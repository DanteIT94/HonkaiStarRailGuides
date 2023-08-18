//
//  CharacterParcing.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 16.08.2023.
//

import Foundation
import UIKit

struct Character {
    let id: String
    let name: String
    let elementURL: String
    let fullImageURL: String?
    let iconImageURL: String
    let pathURL: String
}


enum Element {
    case fire, ice, lightning, imaginary, wind, physical, quantum
    var color: UIColor {
        switch self {
        case .fire: return .red
        case .ice: return .blue
        case .lightning: return .purple
        case .wind: return .green
        case .imaginary: return .yellow
        case .physical: return .lightGray
        case .quantum: return .brown
        }
    }
}

//extension Character {
//    var elementType: Element {
//        switch elementURL {
//        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Elements%2FType_Fire.jpeg?alt=media&token=824c5002-e2a8-4162-a152-e3c241e7a5be":
//            return .fire
//        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Elements%2FType_Ice.jpeg?alt=media&token=97c23b23-41c3-4aa1-88c6-48b325a29242":
//            return .ice
//        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Elements%2FType_Imaginary.jpeg?alt=media&token=bc045ed2-c770-4876-9cbf-8cdae4fe0385":
//            return .imaginary
//        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Elements%2FType_Lightning.jpeg?alt=media&token=4b5e755e-bc1e-4c57-98ac-32190eb390d9":
//            return .lightning
//        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Elements%2FType_Quantum.jpeg?alt=media&token=07208e01-28fa-45de-b1b5-7af1ea3ed38c":
//            return .quantum
//        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Elements%2FType_Wind.jpeg?alt=media&token=4dc817b6-f825-4aa0-ad79-15c00a3aa394":
//            return .wind
//        default:
//            return .physical // или любой другой стандартный элемент, если URL не совпадает
//        }
//    }
//}



