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
    // private var toDoListCoordinator:TODOListScreenCoord?
    
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
        // some code
#endif
        configureServicies()
        configureNavigationController()
        showSplashScreen()
    }
}

// MARK: - Private Functions
extension AppCoordinator: SplashScreenCoordTransitions, LoginScreenCoordTransitions, RepositoryListScreenCoordTransitions{

    func showLoginScreen(){
        let coordinator = LoginScreenCoordinator(navigationController: navigationController, transitions: self)
        coordinator.start()
    }
    
    private func configureNavigationController() {
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    private func configureWindow() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func showSplashScreen() {
        let coordinator = SplashScreenCoordinator(navigationController: navigationController, transitions: self)
        coordinator.start()
    }
    
    func enterApp(repositories: [RepositoryItem]) {
        let toDoListCoordinator = RepositoryListScreenCoord(repositories: repositories, navController: navigationController, transitions: self)
        toDoListCoordinator.start()
    }
    
    private func configureServicies() {
        ServiceHolder.shared.add(RequestManager.shared, for: RequestManager.self)
        ServiceHolder.shared.add(TokensService.shared, for: TokensService.self)
        ServiceHolder.shared.add(UserService.shared, for: UserService.self)
        ServiceHolder.shared.add(TodoService.shared, for: TodoService.self)
    }
}
