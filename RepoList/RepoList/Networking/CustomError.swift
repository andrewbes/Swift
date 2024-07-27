//
//  CustomError.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/17/24.
//

import Foundation
class CustomError: NSObject, Error {
    
    var title: String?
    var message: String
    var code: Int?
    
    init(code: Int? = nil, title: String? = nil, message: String) {
        self.code = code
        self.title = title
        self.message = message
    }
    
    init(message: String) {
        self.message = message
    }
    
    override public var description: String {
        return "Title: \(title ?? ""), Message: \(message)"
    }
}

extension CustomError {
    static func somethingWentWrongError() -> CustomError {
        return CustomError(title: "Error!", message: "Oh no! Looks like something is wrong. Please wait a few minutes and try again.")
    }
    
    static func offlineError() -> CustomError {
        let offlineMessage = "You are offline. Please, check your internet connection to use the app"
        return CustomError(title: "", message: offlineMessage)
    }
}
