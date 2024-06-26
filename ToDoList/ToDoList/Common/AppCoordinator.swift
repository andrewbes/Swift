//
//  AppCoordinator.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 4/26/24.
//

import Foundation
import UIKit

class AppCoordinator {
    private weak var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        print("\(String(describing: self)) - \(#function)")
        start()
    }
    
    deinit {
        print("\(String(describing: self)) - \(#function)")
    }
    
    private let navigationController = UINavigationController()

    func start() {
        configureWindow()
        // just for testing
        #if DEBUG
//            navigationController.navigationBar.isHidden = true
//            showFilter()
//            return
        #endif

        configureNavigationController()
        showSplashScreen()
    }
}

// MARK: - Private Functions
extension AppCoordinator {

    private func showFilterScreen(){
   //     let coordinator = FilterScreenCoord(navController: navigationController, transitions: nil)
   //     coordinator.start()
    }

    private func configureNavigationController() {
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    private func configureWindow() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func showToDoListScreen() {
//        let coordinator = ToDoListScreenCoordinator(navigationController: navigationController, transitions: self)
//        coordinator.start()
    }

    private func showSplashScreen() {
       let coordinator = SplashScreenCoordinator(navigationController: navigationController, transitions: self)
        coordinator.start()
    }
}

extension AppCoordinator : SplashScreenCoordTransitions {
    
}
