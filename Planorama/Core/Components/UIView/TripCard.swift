//
//  TripCard.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 10/05/25.
//

import UIKit

class TripCard: UIView {
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String, dateText: String) {
        self.titleLabel.text = title
        self.dateLabel.text = dateText
    }
    
    private func render() {
        renderTitleLabel()
        renderDateLabel()
    }
    
    private func renderTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        ])
    }
    
    private func renderDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 0),
            dateLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 0),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16)
        ])
    }
}
