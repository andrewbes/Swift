//
//  ServiceHolder.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/17/24.
//

import Foundation

public protocol StoredService {}

public class ServiceHolder {
    private var servicesDictionary: [String: StoredService] = [:]
    
    static var shared: ServiceHolder = {
        let instance = ServiceHolder()
        return instance
    }()
    
    private init() {}
    
    func add<T>(_ instance: StoredService, for protocolType: T.Type) {
        let name = String(reflecting: protocolType)
        servicesDictionary[name] = instance
    }
    
    func get<T>(by type: T.Type = T.self) -> T {
        return get(by: String(reflecting: type))
    }
    
    func remove<T>(by type: T.Type) {
        let name = String(reflecting: type)
        if let _ = servicesDictionary[name] as? T {
            servicesDictionary[name] = nil
        }
    }
    
    private func get<T>(by name: String) -> T {
        guard let service = servicesDictionary[name] as? T else {
            fatalError("Firstly you have to add the service")
        }
        return service
    }
}
