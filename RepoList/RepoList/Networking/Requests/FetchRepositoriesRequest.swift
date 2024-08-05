//
//  FetchRepositoriesRequest.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/17/24.
//

import Foundation
import Alamofire


class FetchRepositoriesRequest: RequestProtocol {
    
    private let username: String
    
    let userService: UserService = ServiceHolder.shared.get()
    
    init() {
        self.username = userService.userName ?? ""
    }
    
    func method() -> HTTPMethod {
        return .get
    }
    
    func fullApiPath() -> String {
        print("\(Defines.serverURL)search/repositories?q=user:\(username)")
        return "\(Defines.serverURL)search/repositories?q=user:\(username)"
    }
    
    func requiresAuth() -> Bool? {
        return true
    }
}

extension FetchRepositoriesRequest {
    
    func perform() async -> RepositoryResponseModel? {
        let result = await self.performRequest(responseModelType: RepositoryResponseModel.self)
        switch result {
        case .success(let responseModel):
            return responseModel
        case .failure(_):
            return nil
        }
    }
}
