//
//  BaseCellModel.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/13/24.
//


import UIKit

    protocol BaseCellModelProtocol {
    var visible: Bool { get set }
    var selected: Bool { get set }
    var cellType: CellType { get set }
    func swapSelection()
    func getHeight() -> CGFloat
}

enum SectionState {
    case closed
    case opened
}

protocol BaseCell : UITableViewCell {
    func configure(with viewModel: BaseCellModelProtocol)
}

enum CellType: Equatable, Hashable {
    case repo
    case empty
    
    func identifier() -> String {
        switch self {
        case .repo:
            return "RepositoryTableViewCell"
        case .empty:
            return "EmptyCell"
        }
    }
}

public class BaseCellModel: BaseCellModelProtocol {
    var visible: Bool = false
    var selected = false
    var cellType: CellType = .empty
    
    init(visible: Bool, cellType: CellType) {
        self.visible = visible
        self.cellType = cellType
    }

    func swapSelection() {
        selected = !selected
    }
    
    func getHeight() -> CGFloat {
        0.0
    }
}
