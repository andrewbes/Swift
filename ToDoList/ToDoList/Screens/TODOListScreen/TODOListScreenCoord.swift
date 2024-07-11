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
    
    weak var viewController = Storyboard._storyboard_name_.controller(withClass: TODOListScreenVC.self)
    private weak var transitions: TODOListScreenCoordTransitions?
    
    init(navController: UINavigationController?,
         transitions: TODOListScreenCoordTransitions?) {
        self.navController = navController
        self.transitions = transitions
        viewController?.viewModel = TODOListScreenVM(self)
    }
    
    init(withRootVC rootVC: UIViewController?,
         transitions: TODOListScreenCoordTransitions?) {
        self.rootVC = rootVC
        self.transitions = transitions
        viewController?.viewModel = TODOListScreenVM(self)
    }

    func start() {
        guard let vc = viewController else { return }
        navController?.pushViewController(vc, animated: true)
    }
    
    func back() {
        navController?.popViewController(animated: true)
    }
    
    deinit {
        print("TODOListScreenCoord - deinit")
    }
}
