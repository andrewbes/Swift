//
//  TokensService.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/17/24.
//

import Foundation

class UserService: StoredService {
    
//    static var shared: UserService = UserService()

    var userName: String? {
        get { return UserDefaultsProvider.userName }
        set { UserDefaultsProvider.userName = newValue
             print("User name = \(userName ?? "")")}
    }
    
    func clearUser() {
        userName = nil
    }
}
