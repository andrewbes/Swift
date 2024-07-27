//
//  Defines.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/17/24.
//

import Foundation

//MARK::typealiases
typealias EmptyClosure = () -> ()
typealias SimpleClosure<T> = (T) -> ()

//MARK::defines
struct Defines {
    
    static let serverURL = ""
    
}

//MARK::platform
struct Platform {
    
    static var isSimulator: Bool {
        return TARGET_IPHONE_SIMULATOR != 0 // simulator
    }
}
