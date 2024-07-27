//
//  MultipartFormDataModel.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/17/24.
//

import Foundation

struct MultipartFormDataModel {
    let data: Data
    let fieldName: String
    let fileName: String
    let mimeType: String
}
