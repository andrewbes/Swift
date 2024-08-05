//
//  ModelProtocol.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 5/20/24.
//

import Foundation
protocol ViewModelProtocol {
    func getCaption() -> String
}

protocol TableViewModelProtocol: ViewModelProtocol {
    func getCellModel(for section: Int, row: Int)-> BaseCellModelProtocol?
}
