//
//  TODOListScreenVM.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 5/20/24.
//

import Foundation

protocol TODOListScreenVMType {
    
}

class TODOListScreenVM: TODOListScreenVMType {
    
    private let coordinator: TODOListScreenCoordType
    
    init(_ coordinator: TODOListScreenCoordType) {
        self.coordinator = coordinator
    }
    
    deinit {
        print("TODOListScreenVM - deinit")
    }
}
