//
//  SplashScreenCoord.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 4/26/24.
//

import UIKit

protocol SplashScreenCoordTransitions: AnyObject {
    func showToDoListScreen()
}

protocol SplashScreenCoordinatorProtocol {
    func showToDoListScreen()
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
    
    func showToDoListScreen() {
        transitions?.showToDoListScreen()
    }
}
