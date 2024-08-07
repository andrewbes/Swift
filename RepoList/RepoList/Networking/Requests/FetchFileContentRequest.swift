//
//  FetchRepositoriesRequest.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/17/24.
//

import Foundation
import Alamofire


class FetchFileContentRequest: RequestProtocol {
    
    private let username: String
    private let repo: String
    private let path: String
    
    let userService: UserService = ServiceHolder.shared.get()
    
    init(repo: String, path: String) {
        self.username = userService.userName ?? ""
        self.repo = repo
        self.path = path
    }
    
    func method() -> HTTPMethod {
        return .get
    }
    
    func fullApiPath() -> String {
        print("\(Defines.serverURL)repos/\(username)/\(repo)/contents/\(path)")
        return "\(Defines.serverURL)repos/\(username)/\(repo)/contents/\(path)"
    }
    
    func requiresAuth() -> Bool? {
        return true
    }
}

extension FetchFileContentRequest {
    
    func perform() async -> GitHubFileContent? {
        let result = await self.performRequest(responseModelType: GitHubFileContent.self)
        switch result {
        case .success(let responseModel):
            return responseModel
        case .failure(_):
            return nil
        }
    }
}
