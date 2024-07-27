//
//  DateCellModel.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/13/24.
//

import UIKit
class RepositoryCellModel: BaseCellModel {
    init(text: String,toDos: [String]?) {
        self.text = text
        self.toDos = toDos
        super.init(visible: true, cellType: .repo)
    }
    
    var text: String
    var toDos: [String]?
    var bgColor: UIColor {
        get {
            if let toDos {
                return toDos.isEmpty ? .systemBlue : .systemPink
            }
            return .yellow
        }
    }
    
    var selected = false
    func swapSelection() {
        selected = !selected
    }
}
