//
//  ConfigurableVCProtocol.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 4/26/24.
//

public protocol ConfigurableVCProtocol {
    func configureUI()
    func configureViews()
    func configureLabels()
    func configureButtons()
    func configureTableView()
}

// MARK: - Default implementation
public extension ConfigurableVCProtocol {
    
    func configureUI() {
        configureViews()
        configureLabels()
        configureButtons()
        configureTableView()
    }
    
    func configureViews() {}
    func configureLabels() {}
    func configureButtons() {}
    func configureTableView() {}
}
