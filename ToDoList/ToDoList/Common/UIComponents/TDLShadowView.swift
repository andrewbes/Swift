//
//  TDLShadowView.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 4/26/24.
//

import UIKit

class TDLShadowView: UIView {
    var shadowView = UIView()

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private functions
    private func setupUI() {
        self.backgroundColor = .clear
        self.clipsToBounds = true
        setupShadowView()
        setShadow()
    }
    
    private func setupShadowView() {
        shadowView.backgroundColor = .white
        shadowView.clipsToBounds = false
        shadowView.layer.cornerRadius = 12
        self.addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            shadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            shadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            shadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
}

// MARK: UI Shadow preferences
extension TDLShadowView {
    func setShadow(shadowColor: CGColor = UIColor.black.cgColor, shadowOffset: CGFloat = 2.0, shadowRadius: CGFloat = 2.0) {
        
        shadowView.layer.shadowColor = shadowColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowOffset = CGSize(width: shadowOffset, height: shadowOffset)
        shadowView.layer.shadowRadius = shadowRadius
    }
    
    func hideShadow() {
        self.layer.shadowColor = UIColor.clear.cgColor
    }
}
