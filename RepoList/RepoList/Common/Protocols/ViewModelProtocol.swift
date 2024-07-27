//
//  ModelProtocol.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 5/20/24.
//

import Foundation
public protocol ViewModelProtocol {
    func getCaption() -> String
}

public protocol TableViewModelProtocol: ViewModelProtocol {
    func getCellModel(for section: Int, row: Int)-> BaseCellModel?
}
