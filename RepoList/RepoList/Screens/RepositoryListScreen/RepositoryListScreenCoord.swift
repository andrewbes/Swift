//
//  TODOListScreenCoord.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 5/20/24.
//

import UIKit

protocol RepositoryListScreenCoordTransitions: AnyObject {
    func showLoginScreen()
}

protocol RepositoryListScreenCoordType {
    func showLoginScreen() 
}

class RepositoryListScreenCoord: RepositoryListScreenCoordType {
 
    weak var rootVC: UIViewController?
    private weak var navController: UINavigationController?
    
    weak var viewController = Storyboard.repositoriesListScreen.controller(withClass: RepositoryListScreenVC.self)
    private weak var transitions: RepositoryListScreenCoordTransitions?
    
    init(repositories: [RepositoryItem] = [], navController: UINavigationController?,
         transitions: RepositoryListScreenCoordTransitions?) {
        self.navController = navController
        self.transitions = transitions
        viewController?.configureWith(model: RepositoryListScreenVM(repositories:repositories, self))
    }
    
    init(repositories: [RepositoryItem] = [], withRootVC rootVC: UIViewController?,
         transitions: RepositoryListScreenCoordTransitions?) {
        self.rootVC = rootVC
        self.transitions = transitions
        viewController?.configureWith(model: RepositoryListScreenVM(repositories:repositories, self))
    }
    
    func start() {
        
        if let viewController = self.viewController {
            self.navController?.setViewControllers([viewController], animated: false)
        }
    }
    
    func back() {
        navController?.popViewController(animated: true)
    }
    
    deinit {
        print("TODOListScreenCoord - deinit")
    }
    
    func showLoginScreen() {
        transitions?.showLoginScreen()
    }
}
