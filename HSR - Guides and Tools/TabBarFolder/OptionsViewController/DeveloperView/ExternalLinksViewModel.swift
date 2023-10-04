//
//  ExternalLinksViewModel.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 03.10.2023.
//

import Foundation
import MessageUI

class ExternalLinksViewModel: ObservableObject {
    @Published var showSafari: Bool = false
    @Published var safariURL: URL? = nil
    
    let email = "ChakyrIT@gmail.com"
    let subject = "Обратная связь"
    let body = ""
    
    func openDeveloperTelegram() {
        if let url = URL(string: "https://t.me/ChakyrIT") {
            self.safariURL = url
            self.showSafari = true
        }
    }
    
    func openAppleEmail() {
        let coded = "mailto:\(email)?subject=\(subject)&body=\(body)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let emailURL = URL(string: coded), UIApplication.shared.canOpenURL(emailURL) {
            UIApplication.shared.open(emailURL)
        }
    }

}
