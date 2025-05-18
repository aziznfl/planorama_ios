//
//  EmptyState.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 11/05/25.
//

import UIKit

class EmptyStateView: UIView {
    private let titleLabel: UILabel = UILabel()
    private let button: UIButton = UIButton()
    private var onButtonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String,
               buttonText: String = "Try again",
               buttonAction: @escaping () -> Void) {
        titleLabel.text = title
        button.setTitle(buttonText, for: .normal)
        onButtonAction = buttonAction
        button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
    }
    
    private func render() {
        renderTitlelabel()
        renderButton()
    }
    
    private func renderTitlelabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func renderButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    @objc private func handleButtonTap() {
        onButtonAction?()
    }
}
