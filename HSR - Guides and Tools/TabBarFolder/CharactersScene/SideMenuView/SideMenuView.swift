//
//  SideMenuView.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 18.10.2023.
//

import UIKit

protocol SideMenuDelegate: AnyObject {
    func sideMenuToggleRequested()
    func resourceButtonTapped()
}

final class SideMenu {
    weak var delegate: SideMenuDelegate?
    
    private let sideMenuWidth: CGFloat = UIScreen.main.bounds.width / 2
    private var sideMenuView: UIView?
    
    init(delegate: SideMenuDelegate, in view: UIView) {
        self.delegate = delegate
        createSideMenu(in: view)
    }
    
    private func createSideMenu(in view: UIView) {
        let menu = UIView()
        menu.backgroundColor = .whiteDayNight
        menu.frame = CGRect(x: -sideMenuWidth, y: 0, width: sideMenuWidth, height: view.frame.height)
        view.addSubview(menu)
        sideMenuView = menu
        addResourceButton()
    }
    
    func activateMenu() {
        if let menu = sideMenuView {
            let isOpened = menu.frame.origin.x == 0
            let targetX: CGFloat = isOpened ? -sideMenuWidth : 0
            UIView.animate(withDuration: 0.5) {
                menu.frame.origin.x = targetX
            }
        }
    }
    
    private func addResourceButton() {
        let button = UIButton(type: .system)
        button.setTitle("Подсчет Смолы", for: .normal)
        button.addTarget(self, action: #selector(resourceButtonTapped), for: .touchUpInside)
        button.frame = CGRect(x: 20, y: 100, width: 150, height: 150)
        sideMenuView?.addSubview(button)
    }
    
    
    @objc private func resourceButtonTapped() {
        delegate?.resourceButtonTapped()
    }
}
