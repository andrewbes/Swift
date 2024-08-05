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
    
    let userService: UserService = ServiceHolder.shared.get()
    
    init(repo: String) {
        self.username = userService.userName ?? ""
        self.repo = repo
    }
    
    func method() -> HTTPMethod {
        return .get
    }
    
    func fullApiPath() -> String {
        let query = "repo:\(username)/\(repo)"
        print("\(Defines.serverURL)search/code?q=TODO \(query)")
        return"\(Defines.serverURL)search/code?q=TODO \(query)"
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
