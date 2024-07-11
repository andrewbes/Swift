//
//  TODOListScreenCoord.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 5/20/24.
//

import UIKit

protocol TODOListScreenCoordTransitions: AnyObject {
}

protocol TODOListScreenCoordType {
}

class TODOListScreenCoord: TODOListScreenCoordType {
    
    weak var rootVC: UIViewController?
    private weak var navController: UINavigationController?
    
    weak var viewController = Storyboard.toDoListScreen.controller(withClass: TODOListScreenVC.self)
    private weak var transitions: TODOListScreenCoordTransitions?
    
    init(navController: UINavigationController?,
         transitions: TODOListScreenCoordTransitions?) {
        self.navController = navController
        self.transitions = transitions
        viewController?.configureWith(model: TODOListScreenVM(self))
    }
    
    init(withRootVC rootVC: UIViewController?,
         transitions: TODOListScreenCoordTransitions?) {
        self.rootVC = rootVC
        self.transitions = transitions
        viewController?.configureWith(model: TODOListScreenVM(self))
    }

    func start() {
        if let viewController {
            navController?.setViewControllers([viewController], animated: false)
        }
    }
    
    func back() {
        navController?.popViewController(animated: true)
    }
    
    deinit {
        print("TODOListScreenCoord - deinit")
    }
}
