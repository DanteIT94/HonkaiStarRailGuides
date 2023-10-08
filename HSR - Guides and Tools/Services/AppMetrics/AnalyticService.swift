//
//  Analyticservice.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 08.10.2023.
//

import Foundation
import YandexMobileMetrica

struct AnalyticService {
    static func activate() {
        guard let configuration = YMMYandexMetricaConfiguration(apiKey: "49de5a3a-9dc8-4442-9166-4ba16dda6b95") else { return }
        YMMYandexMetrica.activate(with: configuration)
    }
}
