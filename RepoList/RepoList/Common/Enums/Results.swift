//
//  Results.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/27/24.
//

import Foundation

enum SimpleResult {
    case failure(CustomError)
    case success
}

enum CustomResult<T> {
    case failure(CustomError)
    case success(T)
}
