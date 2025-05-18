//
//  AccountDetail.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 11/05/25.
//

import SDWebImage
import UIKit

class AccountDetailView: UIView {
    private lazy var image = UIImageView().parent(to: self)
    private lazy var nameLabel = UILabel().parent(to: self)
    private lazy var emailLabel = UILabel().parent(to: self)
    private lazy var buttonSettings: UIButton = .init(type: .system).parent(to: self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(imageUrl: String, name: String, email: String) {
        image.sd_setImage(with: URL(string: imageUrl))
        nameLabel.text = name
        emailLabel.text = email
    }
    
    private func render() {
        renderImageProfile()
        renderSettings()
        renderName()
        renderEmail()
        
        bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: 16).isActive = true
    }
    
    private func renderImageProfile() {
        image.layer.cornerRadius = 24
        image.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            image.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            image.widthAnchor.constraint(equalToConstant: 48),
            image.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    private func renderSettings() {
        buttonSettings.sizeThatFits(CGSize(width: 44, height: 44))
        
        NSLayoutConstraint.activate([
            buttonSettings.topAnchor.constraint(equalTo: image.topAnchor, constant: 0),
            buttonSettings.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ])
    }
    
    private func renderName() {
        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: image.topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: buttonSettings.leftAnchor, constant: 8),
        ])
    }
    
    private func renderEmail() {
        emailLabel.font = .systemFont(ofSize: 14)
        emailLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            emailLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            emailLabel.rightAnchor.constraint(equalTo: buttonSettings.leftAnchor, constant: 16),
        ])
    }
}
