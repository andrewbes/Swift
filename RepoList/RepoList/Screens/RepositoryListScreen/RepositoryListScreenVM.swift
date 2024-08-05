//
//  TODOListScreenVM.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 5/20/24.
//

import Foundation

protocol RepositoryListScreenVMType: TableViewModelProtocol {
    func getCaption() -> String
    func fetchTodos(repo: String) async -> [String]?
    var repositoriesCount: Int { get }
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func selectedCell(row: Int, completion: @escaping ()->() )
    
    func logout()
}

class RepositoryListScreenVM: RepositoryListScreenVMType {
    
    let tokenService: TokensService = ServiceHolder.shared.get()
    let userService: UserService = ServiceHolder.shared.get()
    let todoService: TodoService = ServiceHolder.shared.get()

    private let coordinator: RepositoryListScreenCoordType
    private var repositories: [RepositoryItem]
    private var cellsModels: [RepositoryCellModel] = []
    var repositoriesCount: Int {
        get { repositories.count }
    }
    
    init(repositories: [RepositoryItem] = [], _ coordinator: RepositoryListScreenCoordType) {
        self.coordinator = coordinator
        self.repositories = repositories
        initCells()
    }
    
    deinit {
        print("RepositoriesScreenVM - deinit")
    }
}

extension RepositoryListScreenVM {
    
    func initCells() {
        for repo in repositories {
            let model: RepositoryCellModel = .init(
                text: (repositories.isEmpty ? "" : repo.name) ?? "",
                toDos: nil);
            cellsModels.append(model)
        }
    }
    
    func getCaption() -> String {
        "[ Repositories ]"
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        cellsModels[indexPath.row].selected ? 200 : 54
    }
    
    func getCellModel(for section: Int, row: Int) -> BaseCellModel? {
        return cellsModels[row]
    }
    
    func fetchTodos(repo: String) async -> [String]? {
            let file = await todoService.searchTodos(in: repo)
            print("file: \(file)")
            return await todoService.fetchFileContent(repo: repo, path: file.first?.path ?? "")
    }
    
    func selectedCell(row: Int, completion: @escaping ()->() ) {
        cellsModels[row].swapSelection()
        if cellsModels[row].selected, cellsModels[row].toDos == nil {
            Task {
                if let toDoLines = await fetchTodos(repo: repositories[row].name ?? "") {
                    cellsModels[row].toDos = toDoLines
                }
                completion()
            }
        }
        else {
            completion()
        }
    }
}

//MARK: Navigation
extension RepositoryListScreenVM {
    func logout() {
        tokenService.clearTokens()
        userService.clearUser()
        coordinator.showLoginScreen()
    }
}
