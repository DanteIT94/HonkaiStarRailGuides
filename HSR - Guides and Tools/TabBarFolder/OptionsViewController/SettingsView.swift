//
//  OptionsViewController.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 16.08.2023.
//

import SwiftUI

@available(iOS 14.0, *)
struct SettingsView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = UserDefaults.standard.bool(forKey: "isDarkMode")
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Внешний Вид")) {
                    Toggle("Темная тема", isOn: $isDarkMode)
                        .onChange(of: isDarkMode) { newValue in
                            NotificationCenter.default.post(name: .didChangeTheme, object: nil)
                        }
                }
                Section(header: Text("Информация")) {
                    NavigationLink("О разработчике", destination: DeveloperView())
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Настройки").font(.headline)
                }
            }
        }.onAppear {
            isDarkMode = UIApplication.shared.windows.first?.rootViewController?.traitCollection.userInterfaceStyle == .dark ? true : false
        }
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
