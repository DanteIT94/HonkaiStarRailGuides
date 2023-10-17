//
//  Character + Extension.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 07.10.2023.
//

import Foundation

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

extension Character {
    var pathType: Path {
        switch pathURL {
        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Path%2FDestruction.jpeg?alt=media&token=bb025a63-9c92-4540-8e9f-663cc81cfab5":
            return .destruction
        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Path%2FHarmony.jpeg?alt=media&token=be7675af-9143-4fa0-94a0-72da1bb44496":
            return .harmony
        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Path%2FAbundance.jpeg?alt=media&token=35ceed71-72dd-4cda-8d3b-c4b3277c0f41":
            return .abundance
        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Path%2FHunt.jpeg?alt=media&token=bda33738-4be9-418a-b8da-de57737ce8ae":
            return .hunt
        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Path%2FPreservation.jpeg?alt=media&token=6bb45ed3-9800-40f3-b141-ea8661f2f1cf":
            return .preservation
        case "https://firebasestorage.googleapis.com/v0/b/hsr---guides-and-tools.appspot.com/o/Path%2FErudition.jpeg?alt=media&token=dcb46336-6d6a-4a29-a1b3-9bbf94c8da4b":
            return .erudition
        default: 
            return .nihility
        }
    }
}
