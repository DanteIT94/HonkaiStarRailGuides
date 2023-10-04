//
//  contactViews.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 03.10.2023.
//

import Foundation
import SafariServices
import MessageUI
import SwiftUI


struct SafariView: UIViewControllerRepresentable {
    let url: URL
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

