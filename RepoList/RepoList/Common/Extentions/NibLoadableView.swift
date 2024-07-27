//
//  NibLoadableView.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 1/7/24.
//

import UIKit

protocol NibLoadableView {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
