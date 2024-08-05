//
//  Defines.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/17/24.
//

import Foundation

struct Defines {
    
    static let serverURL = "https://api.github.com/"
    
}

struct Platform {
    
    static var isSimulator: Bool {
        return TARGET_IPHONE_SIMULATOR != 0 // simulator
    }
}
