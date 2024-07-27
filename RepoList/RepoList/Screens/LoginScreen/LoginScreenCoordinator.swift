//
//  SplashScreenCoord.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 4/26/24.
//

import UIKit

protocol LoginScreenCoordTransitions: AnyObject {
    func enterApp(repositories: [RepositoryItem])
}

protocol LoginScreenCoordinatorProtocol {
    func showRepositoriesListScreen(repositories: [RepositoryItem])
}

class LoginScreenCoordinator: LoginScreenCoordinatorProtocol {

    weak var rootVC: UIViewController?
    private weak var navigationController: UINavigationController?
    
    weak var viewController = Storyboard.loginScreen.controller(withClass: LoginScreenVC.self)
    private weak var transitions: LoginScreenCoordTransitions?
    
    init(navigationController: UINavigationController?,
         transitions: LoginScreenCoordTransitions?) {
        self.navigationController = navigationController
        self.transitions = transitions
        viewController?.viewModel = LoginScreenVM(self)
    }
    
    init(withRootVC rootVC: UIViewController?,
         transitions: LoginScreenCoordTransitions?) {
        self.rootVC = rootVC
        self.transitions = transitions
        viewController?.viewModel = LoginScreenVM(self)
    }

    func start() {
        guard let vc = viewController else { return }
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("LoginScreenCoord - deinit")
    }
    
    func showRepositoriesListScreen(repositories: [RepositoryItem]) {
        transitions?.enterApp(repositories: repositories)
    }
}
