//
//  Storyboard.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 4/26/24.
//

import Foundation
import UIKit

struct Storyboard {
    static let splashScreen = UIStoryboard(name: "SplashScreen", bundle: nil)
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self.self)
    }
}

extension UIStoryboard {
    
    func instantiateViewController<T: StoryboardIdentifiable>() -> T? {
        return instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T
    }
    
    func controller<T: UIViewController>(withClass: T.Type) -> T? {
        let identifier = withClass.identifier
        return instantiateViewController(withIdentifier: identifier) as? T
    }
}

extension UIViewController: StoryboardIdentifiable { }

extension UIStoryboard {
    
    public func viewController<ViewController: UIViewController>(_ identifier: String) -> ViewController {
        guard let controller = instantiateViewController(withIdentifier: identifier) as? ViewController else { fatalError("The storyboard has no \(identifier)") }
        return controller
    }
    
}
