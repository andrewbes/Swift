//
//  BaseCellModel.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/13/24.
//


import UIKit

protocol CellsViewModel {
    var visible: Bool { get set }
}

enum SectionState {
    case closed
    case opened
}

protocol BaseCell : UITableViewCell {
    func configure(with viewModel: CellsViewModel)
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

public class BaseCellModel: CellsViewModel {
    var visible: Bool = false
    var cellType: CellType = .empty
    init(visible: Bool, cellType: CellType) {
        self.visible = visible
        self.cellType = cellType
    }
}
