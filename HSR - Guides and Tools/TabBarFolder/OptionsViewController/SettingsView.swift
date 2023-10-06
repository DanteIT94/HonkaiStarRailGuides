//
//  OptionsViewController.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 16.08.2023.
//

import SwiftUI

@available(iOS 14.0, *)
struct SettingsView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Внешний Вид")) {
                    Toggle("Темная тема", isOn: $isDarkMode)
                }
                
                Section(header: Text("Информация")) {
                    NavigationLink("О разработчике", destination: DeveloperView())
                    NavigationLink("Credits", destination: Text("Credits Info"))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Настройки").font(.headline)
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            SettingsView()
        } else {
            
        }
    }
}
