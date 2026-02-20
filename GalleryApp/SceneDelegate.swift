//
//  SceneDelegate.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 30.01.26.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }

        let viewModel = ViewModel()
        let rootVC = ViewController(viewModel: viewModel)

        let nav = UINavigationController(rootViewController: rootVC)

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }
}
