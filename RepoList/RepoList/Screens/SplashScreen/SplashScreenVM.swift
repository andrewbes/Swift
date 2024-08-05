//
//  SplashScreenVM.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 4/26/24.
//

import Foundation

protocol SplashScreenVMType: ViewModelProtocol {
    func showNextScreen()
}

class SplashScreenVM: SplashScreenVMType {
    
    let userService: UserService = ServiceHolder.shared.get()
    let todoService: TodoService = ServiceHolder.shared.get()
    
    private let coordinator: SplashScreenCoordinatorProtocol
    
    init(_ coordinator: SplashScreenCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    deinit {
        print("SplashScreenVM - deinit")
    }
}

// MARK: UI
extension SplashScreenVM {
    
    func getCaption() -> String {
        "[ GitHub's TODO List ]"
    }
    
}

// MARK: Navigation
extension SplashScreenVM {
    
    func showNextScreen() {
        if userService.userName == nil {
            showLoginScreen()
        }
        else {
            showRepositoryListScreen()
        }
    }
    
    private func showLoginScreen() {
        self.coordinator.showLoginScreen()
    }
    
    private func showRepositoryListScreen() {
        
        Task {
            let repositories = await todoService.fetchRepositories()
            if let items = repositories?.items, !items.isEmpty {
                DispatchQueue.main.async {
                    self.coordinator.showRepositoryListScreen(repositories:items)
                }
            }
            else {
                DispatchQueue.main.async {
                    self.coordinator.showLoginScreen()
                }
            }
        }
    }
    
}
