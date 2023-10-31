//
//  AppDelegate.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 16.08.2023.
//

import UIKit
import FirebaseCore
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        AnalyticService.activate()
        
        UserDefaults.standard.set(0, forKey: "closeCounter")
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                    if granted {
                        print("Notification permission granted.")
                    } else {
                        print("Notification permission denied.")
                    }
                }
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    //метод для обновления энергии до 240 единиц при получении уведомления
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "energyFullNotification" {
            UserDefaults.standard.setValue("240", forKey: "energyValue")
        }
        completionHandler()
    }
 
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

