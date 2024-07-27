//
//  UITableView.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 1/7/24.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String { return String(describing: self) }
}

extension UITableViewCell: NibLoadableView {}

extension UITableView {
    func registerCells(_ cells: [String]) {
        cells.forEach {
            register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0)
        }
    }
    
    func registerCell<T: UITableViewCell>(cellType: T.Type) {
        self.register(UINib(nibName: T.nibName, bundle: nil), forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.nibName, for: indexPath) as? T else {
            return nil
        }
        
        return cell
    }
}
