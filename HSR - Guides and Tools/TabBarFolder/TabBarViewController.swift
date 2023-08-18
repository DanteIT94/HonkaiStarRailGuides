//
//  TabBarViewController.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 16.08.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabViewController()
        view.backgroundColor = .white
        
    }
    
    //MARK: -Private Methods
    private func createTabViewController() {
        tabBar.barTintColor = .clear
        tabBar.backgroundColor = .clear
        
        
        let characterVC = CharactesViewController()
        let guidesNavigationController = UINavigationController(rootViewController: characterVC)
        characterVC.tabBarItem = UITabBarItem(
            title: "Главное",
            image: UIImage(systemName: "archivebox"),
            selectedImage: nil)
        
        
        let optionsViewController = OptionsViewController()
        optionsViewController.tabBarItem = UITabBarItem(
            title: "Настройки",
            image: UIImage(systemName: "doc.badge.gearshape.fill"),
            selectedImage: nil)
        
        self.viewControllers = [guidesNavigationController, optionsViewController]
    }
}

