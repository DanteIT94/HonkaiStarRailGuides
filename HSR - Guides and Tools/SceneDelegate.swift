//
//  SceneDelegate.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 16.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let loadingVC = LaunchLoadingViewController()
        var view: CharactersView?
        loadingVC.presenter = CharacterPresenter(view: view)
        window?.rootViewController = loadingVC
        window?.makeKeyAndVisible()
    }


}

