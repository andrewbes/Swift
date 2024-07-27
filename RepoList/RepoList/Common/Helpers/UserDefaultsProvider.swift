//
//  UserDefaultsProvider.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/17/24.
//

import Foundation

class UserDefaultsProvider {
    
    struct Keys {
        static let userName = "userName"
    }
    
    static let userDefaults = UserDefaults.standard

    static var userName: String? {
        set {
            if let _ = newValue {
                userDefaults.set(newValue, forKey: Keys.userName)
            } else {
                UserDefaults.standard.removeObject(forKey: Keys.userName)
            }
        }
        get { return userDefaults.string(forKey: Keys.userName) }
    }
}
