//
//  FetchRepositoriesRequest.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/17/24.
//

import Foundation
import Alamofire


class SearchTodosRequest: RequestProtocol {
    
    private let username: String

    private let repo: String
    
    init(repo: String) {
        self.username = UserService.shared.userName ?? ""
        self.repo = repo
    }
    
    func method() -> HTTPMethod {
        return .get
    }
    
    func fullApiPath() -> String {
        let query = "repo:\(username)/\(repo)"
        print("https://api.github.com/search/code?q=TODO \(query)")
        return"https://api.github.com/search/code?q=TODO \(query)"
    }
    
    func requiresAuth() -> Bool? {
        return true
    }
}

extension SearchTodosRequest {
    
    func perform() async -> SearchResult? {
 
        let result = await self.performRequest(responseModelType: SearchResult.self)
        switch result {
        case .success(let responseModel):
            return responseModel
        case .failure(_):
            return nil
        }
    }
}
