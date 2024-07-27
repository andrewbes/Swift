//
//  TokensService.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/17/24.
//

import Foundation


class TodoService: StoredService {
    
    static var shared: TodoService = TodoService()
    
    func fetchRepositories() async -> RepositoryResponseModel?{
        let request = FetchRepositoriesRequest()
        if let repositories = await request.perform() {
            print(repositories)
            return repositories
        }
        return nil
    }
    
    func fetchFileContent(repo: String, path: String)  async -> [String]? {
        let request = FetchFileContentRequest(repo: repo, path: path)
        if let fileContent = await request.perform() {
            print(fileContent.content)
            if let decodedContent = Data(base64Encoded: fileContent.content, options: .ignoreUnknownCharacters) {
                let content = String(data: decodedContent, encoding: .utf8)
                print("content: \(content ?? "")")
                return extractTODOComments(from: content ?? "")
            }
        }
        return []
    }

    func searchTodos(in repo: String) async -> [SearchResult.Item] {
        let request = SearchTodosRequest(repo: repo)
        if let searchResult = await request.perform() {
            print("searchTodos: \(searchResult)")
            return searchResult.items
        }
        return []
    }
    
    private func extractTODOComments(from content: String) -> [String] {
        let lines = content.split(separator: "\n")
        return lines.filter { $0.contains("TODO") }.map { String($0) }
    }
}
