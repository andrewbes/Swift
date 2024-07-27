//
//  KeychainProvider.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/17/24.
//

import Foundation
import SwiftKeychainWrapper

class KeychainProvider {
    
    struct Keys {
        static let githubToken = "githubToken"
    }
    
    static let keychainWrapper = KeychainWrapper.standard
    
    static var githubToken: String? {
        get {
            return keychainWrapper.string(forKey: Keys.githubToken)
        }
        
        set {
            if let newValue {
                keychainWrapper.set(newValue, forKey: Keys.githubToken)
            } else {
                keychainWrapper.removeObject(forKey: Keys.githubToken)
            }
        }
    }
}
