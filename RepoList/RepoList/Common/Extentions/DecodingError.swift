//
//  DecodingError.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/17/24.
//

import Foundation
extension DecodingError {
    
    public var errorString: String? {
        switch self {
        case .dataCorrupted(let context):
            return context.debugDescription
        case .keyNotFound(_, let context):
            return context.debugDescription
        case .typeMismatch(_, let context):
            return context.debugDescription
        case .valueNotFound(_, let context):
            return context.debugDescription
        default: return self.localizedDescription
        }
    }
}
