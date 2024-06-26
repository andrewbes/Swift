//
//  SplashScreenVM.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 4/26/24.
//

import Foundation

protocol SplashScreenVMType {
    
}

class SplashScreenVM: SplashScreenVMType {
    
    private let coordinator: SplashScreenCoordinatorProtocol
    
    init(_ coordinator: SplashScreenCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    deinit {
        print("SplashScreenVM - deinit")
    }
}
