//
//  UIKitViewControllerWrapper.swift
//  IntegrationApp
//
//  Created by Abdurrahman Polat on 25.06.2025.
//

import UIKit
import SwiftUI

// MARK: - 6. UIKit View Controller'ı SwiftUI'de Gösterme

struct UIKitViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return CustomUIKitViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

class CustomUIKitViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Navigation setup
        title = "UIKit View Controller"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissView)
        )
        
        // SwiftUI View'ı UIKit içinde gösterme
        let swiftUIView = SwiftUICardView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        // Auto Layout
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            hostingController.view.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        // UIKit Label
        let label = UILabel()
        label.text = "Bu bir UIKit Label'ı"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .systemBlue
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: hostingController.view.bottomAnchor, constant: 30),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func dismissView() {
        dismiss(animated: true)
    }
}
