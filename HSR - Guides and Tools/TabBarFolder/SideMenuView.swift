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
    func characterProgressButtonTapped()
    func didOpenMenu()
    func didCloseMenu()
}

final class SideMenu {
    weak var delegate: SideMenuDelegate?
    
    private let sideMenuWidth: CGFloat = UIScreen.main.bounds.width / 2
    private var sideMenuView: UIView?
    
    init(delegate: SideMenuDelegate, in view: UIView) {
        self.delegate = delegate
        createSideMenu(in: view)
    }
    
    func createSideMenu(in view: UIView) {
        let menu = UIView()
        menu.backgroundColor = .whiteDayNight
        menu.frame = CGRect(x: -sideMenuWidth, y: 0, width: sideMenuWidth, height: view.frame.height)
        view.addSubview(menu)
        sideMenuView = menu
    }
    
    func activateMenu() {
        if let menu = sideMenuView {
            let isOpened = menu.frame.origin.x == 0
            let targetX: CGFloat = isOpened ? -sideMenuWidth : 0
            UIView.animate(withDuration: 0.5) {
                menu.frame.origin.x = targetX
            } completion: { _ in
                if isOpened {
                    self.delegate?.didCloseMenu()
                } else {
                    self.delegate?.didOpenMenu()
                }
            }
        }
    }
    
    func deactivateMenu() {
        if let menu = sideMenuView {
            if menu.frame.origin.x == 0 {
                UIView.animate(withDuration: 0.5) {
                    menu.frame.origin.x = -self.sideMenuWidth
                }
            }
        }
        delegate?.didCloseMenu()
    }
    
    //Добавление кнопок на СайдМеню
    func addButton(title: String, x: CGFloat, y: CGFloat, action: Selector, traitCollection: UITraitCollection) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.whiteDayNight, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        
        button.backgroundColor = .blackDayNight
        button.layer.cornerRadius = 10
        
        if traitCollection.userInterfaceStyle == .dark {
            button.layer.shadowColor = UIColor.blackDayNight.cgColor
        } else {
            button.layer.shadowColor = UIColor.whiteDayNight.cgColor
        }
        
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.5
        
        //задаем размер
        button.frame = CGRect(x: x, y: y, width: 150, height: 50)
        
        //Добавляем на Вьюху
        sideMenuView?.addSubview(button)
    }
    
    @objc private func resourceButtonTapped() {
        delegate?.resourceButtonTapped()
    }
    
    @objc private func characterProgressButtonTapped() {
        delegate?.characterProgressButtonTapped()
    }
    
}
