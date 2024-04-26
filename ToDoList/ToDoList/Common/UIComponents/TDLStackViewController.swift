//
//  TDLStackViewController.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 4/26/24.
//

import UIKit

open class SGStackViewController: UIViewController, ConfigurableVCProtocol {

    public lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
        
    public lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    
    // MARK: - UI
    open func addContent() {
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
    }
    
    open func styleContent() { /* Default Implementation, override in subclass if needed */ }
    
    open func configureContent() { /* Default Implementation, override in subclass if needed */ }
    
    open func makeConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    open func removeConstraints() {
        scrollView.removeConstraints(scrollView.constraints)
        stackView.removeConstraints(stackView.constraints)
    }
    
    open func resetConstraints() {
        removeConstraints()
        makeConstraints()
    }
    
    open func updateContent(animated: Bool) { /* Default Implementation, override in subclass if needed */ }
}

extension UIStackView {
    func addArrangedSubview(_ view: UIView, withSpacing spacing: CGFloat = 0.0) {
        if self.axis == .vertical {
            let spacer = UIView()
            spacer.setContentHuggingPriority(.defaultLow, for: .vertical)
            spacer.translatesAutoresizingMaskIntoConstraints = false
            spacer.heightAnchor.constraint(equalToConstant: spacing).isActive = true
            self.addArrangedSubview(spacer)
            self.sendSubviewToBack(spacer)
        }
        self.addArrangedSubview(view)
    }
}
