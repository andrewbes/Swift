//
//  Defines.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/17/24.
//

import Foundation

//MARK::defines
struct Defines {
    
    static let serverURL = "https://api.github.com/"
    
}

//MARK::platform
struct Platform {
    
    static var isSimulator: Bool {
        return TARGET_IPHONE_SIMULATOR != 0 // simulator
    }
}
