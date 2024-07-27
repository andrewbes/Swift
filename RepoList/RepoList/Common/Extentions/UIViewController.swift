//
//  UIViewController.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 4/26/24.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    
    class var identifier: String {
        let separator = "."
        let fullName = String(describing: self)
        if fullName.contains(separator) {
            let items = fullName.components(separatedBy: separator)
            if let name = items.last {
                return name
            }
        }
        return fullName
    }
    
    func showHUD() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            if !SVProgressHUD.isVisible() {
                SVProgressHUD.show()
            }
        }
    }
    
    func hideHUD() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            SVProgressHUD.dismiss()
        }
    }
    
    func displaySimpleAlertWith(title: String? = nil, message: String? = nil, actionTitle: String = NSLocalizedString("Ok", comment: "Ok"), preferredStyle: UIAlertController.Style = .alert, style: UIAlertAction.Style = .default, hasCancelButton: Bool = false,  handler: ((UIAlertAction) -> Void)? = nil)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let okAction = UIAlertAction(title: actionTitle, style: style, handler: handler)
        
        alert.addAction(okAction)
        
        if hasCancelButton {
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil)
            alert.addAction(cancelAction)
        }
        alert.preferredAction = okAction
        
        present(alert, animated: true, completion: nil)
    }
   
    func addTapToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(tap:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(tap: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

