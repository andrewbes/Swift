//
//  TokensService.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/17/24.
//

import Foundation

class TokensService: StoredService {
    
//    static var shared: TokensService = TokensService()

    var githubToken: String? {
        get { return KeychainProvider.githubToken }
        set { KeychainProvider.githubToken = newValue
             print("Github Token = \(githubToken ?? "")")}
    }
    
    func clearTokens() {
        githubToken = nil
    }
}
