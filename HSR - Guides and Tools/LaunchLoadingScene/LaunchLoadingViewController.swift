//
//  LaunchLoadingViewController.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 08.10.2023.
//

import UIKit

final class LaunchLoadingViewController: UIViewController {
    
    var presenter: CharacterPresenter!
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "main_logo")
        return imageView
    }()
    
    let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = .white
        progress.progressTintColor = .blueUni
        return progress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateProgressBar(_:)), name: NSNotification.Name("updateProgressBar"), object: nil)
        
        presenter.progressDelegate = self
        presenter.viewDidLoad()
    }
    
    
    private func setupLayout() {
        view.addSubview(logoImageView)
        view.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            
            progressView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    @objc func updateProgressBar(_ notification: Notification) {
        if let progress = notification.userInfo?["progress"] as? Float {
            self.progressView.progress = progress
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension LaunchLoadingViewController: ProgressDelegate {
    func didLoadCharacters() {
        progressView.isHidden = true
        let tabBar = TabBarViewController()
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
}
