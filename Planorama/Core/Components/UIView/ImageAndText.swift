//
//  ImageAndText.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 21/05/25.
//

import UIKit

class ImageAndText: UIView {
    private lazy var imageView: UIImageView = UIImageView().parent(to: self)
    private lazy var textLabel: UILabel = UILabel().parent(to: self)
    
    func configure(image: UIImage?, text: String) {
        imageView.image = image
        textLabel.text = text
        
        render()
    }
    
    private func render() {
        textLabel.font = .systemFont(ofSize: 12, weight: .regular)
        textLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 14),
            imageView.heightAnchor.constraint(equalToConstant: 14),
            
            textLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            textLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 4),
            
            bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
        ])
    }
}
