//
//  AppParametrs.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 08.10.2023.
//

import Foundation

import Foundation

enum AppMetricsParams {
    enum Item: String {
    
        case filterButtonTap
        case sortButtonTap
        case imageGuideButtonTap
        
    }
    
    enum Event: String {
        ///Открытие нового экрана
        case open
        ///Закрытие  прежнего экрана
        case close
        ///Обработка нажатия на кликабельный объект
        case click
    }
}
