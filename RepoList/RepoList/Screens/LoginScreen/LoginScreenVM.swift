//
//  SplashScreenVM.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 4/26/24.
//

import Foundation

protocol LoginScreenVMType: ViewModelProtocol {
    func login()
    var githubName: String? {get set}
    var githubToken: String? {get set}
}

protocol LoginScreenVMDelegate {
    func loginIncorrect()
}

class LoginScreenVM: LoginScreenVMType {

    let tokenService: TokensService = ServiceHolder.shared.get()
    let userService: UserService = ServiceHolder.shared.get()
    let todoService: TodoService = ServiceHolder.shared.get()
    
    var delegate:LoginScreenVMDelegate?
    
    var githubName: String? {
        get { return name }
        set {
            name = newValue
            print("Github Name = \(newValue ?? "")")}
    }
    
    var githubToken: String? {
        get { return token }
        set { 
            token = newValue
            print("Github Token = \(newValue ?? "")")}
    }
    
    private var name: String?
    private var token: String?
    private let coordinator: LoginScreenCoordinatorProtocol
    
    init(_ coordinator: LoginScreenCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    deinit {
        print("LoginScreenVM - deinit")
    }
    
    func login() {
        userService.userName = name
        tokenService.githubToken = token
        Task {
            let repositories = await todoService.fetchRepositories()
            guard let items = repositories?.items else { return }
            if items.isEmpty {
                delegate?.loginIncorrect()
            }
            else {
                DispatchQueue.main.async {
                    self.userService.userName = self.name
                    self.tokenService.githubToken = self.token
                    self.coordinator.showRepositoriesListScreen(repositories:items)
                }
            }
        }
    }
}

extension LoginScreenVM {
    
    func getCaption() -> String {
        "[ Login ]"
    }
}
