//
//  AddTripPlaceViewCell.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 22/05/25.
//

import UIKit

class AddTripPlaceViewCell: UITableViewCell {
    static let identifier = "AddTripPlaceViewCell"
    
    private lazy var image: UIImageView = UIImageView().parent(to: contentView)
    private lazy var label: UILabel = UILabel().parent(to: contentView)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        render()
    }
    
    func configure(with image: UIImage?, text: String) {
        self.image.image = image
        self.label.text = text
    }
    
    private func render() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 48),
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 4),
            label.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
        ])
    }
}
