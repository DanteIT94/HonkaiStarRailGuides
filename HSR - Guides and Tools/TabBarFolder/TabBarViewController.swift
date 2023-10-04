//
//  TabBarViewController.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 16.08.2023.
//

import UIKit
import SwiftUI
import UserNotifications

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabViewController()
        view.backgroundColor = .white
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]) { granted, error in
                if granted {
                    // Создание контента уведомления
                    let content = UNMutableNotificationContent()
                    content.title = "Обновление уже в игре"
                    content.body = "Мы обновили гайды специально для тебя)"
                    
                    // Триггер уведомления
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats:  false)
                    
                    let request = UNNotificationRequest(identifier: "testNotification", content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request)
                }
                
            }
        
    }
    
    //MARK: -Private Methods
    private func createTabViewController() {
        tabBar.barTintColor = .clear
        tabBar.backgroundColor = .clear
        
        
        let characterVC = CharactersViewController()
        let guidesNavigationController = UINavigationController(rootViewController: characterVC)
        characterVC.tabBarItem = UITabBarItem(
            title: "Главное",
            image: UIImage(systemName: "archivebox"),
            selectedImage: nil)
        
        
        if #available(iOS 14.0, *) {
            let settingsView = SettingsView()
            let settingsVC = UIHostingController(rootView: settingsView)
            settingsVC.tabBarItem = UITabBarItem(
                title: "Настройки",
                image: UIImage(systemName: "doc.badge.gearshape.fill"),
                selectedImage: nil)
            self.viewControllers = [guidesNavigationController, settingsVC]
        } else {
            // Fallback on earlier versions
        }
    
    }
}

