//
//  UIView.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/10/24.
//

import UIKit

extension UIView {
    func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}
