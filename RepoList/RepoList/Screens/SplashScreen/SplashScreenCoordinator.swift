//
//  SplashScreenCoord.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 4/26/24.
//

import UIKit

protocol SplashScreenCoordTransitions: AnyObject {
    func enterApp(repositories: [RepositoryItem])
    func showLoginScreen()
}

protocol SplashScreenCoordinatorProtocol {
    func showRepositoryListScreen(repositories: [RepositoryItem])
    func showLoginScreen()
}

class SplashScreenCoordinator: SplashScreenCoordinatorProtocol {

    weak var rootVC: UIViewController?
    private weak var navigationController: UINavigationController?
    
    weak var viewController = Storyboard.splashScreen.controller(withClass: SplashScreenVC.self)
    private weak var transitions: SplashScreenCoordTransitions?
    
    init(navigationController: UINavigationController?,
         transitions: SplashScreenCoordTransitions?) {
        self.navigationController = navigationController
        self.transitions = transitions
        viewController?.viewModel = SplashScreenVM(self)
    }
    
    init(withRootVC rootVC: UIViewController?,
         transitions: SplashScreenCoordTransitions?) {
        self.rootVC = rootVC
        self.transitions = transitions
        viewController?.viewModel = SplashScreenVM(self)
    }

    func start() {
        guard let vc = viewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("SplashScreenCoord - deinit")
    }
    
    func showRepositoryListScreen(repositories: [RepositoryItem]) {

        transitions?.enterApp(repositories: repositories)
    }
    
    func showLoginScreen() {
        transitions?.showLoginScreen()
    }
}
