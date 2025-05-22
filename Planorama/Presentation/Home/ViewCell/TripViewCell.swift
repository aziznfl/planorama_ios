//
//  TripViewCell.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 19/05/25.
//

import UIKit

class TripViewCell: UITableViewCell {
    static let identifier = "TripViewCell"
    
    private lazy var background: UIView = UIView().parent(to: contentView)
    private lazy var backgroundImage: UIImageView = UIImageView().parent(to: background)
    private lazy var titleLabel: UILabel = UILabel().parent(to: background)
    private lazy var dateLabel: UILabel = UILabel().parent(to: background)
    private lazy var activityLabel: UILabel = UILabel().parent(to: background)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        render()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let mask = CAGradientLayer()
        mask.startPoint = CGPoint(x: 0.0, y: 0.5)
        mask.endPoint = CGPoint(x: 1.0, y: 0.5)
        mask.colors = [
            UIColor.white.withAlphaComponent(0.0).cgColor,
            UIColor.white.withAlphaComponent(0.2).cgColor,
            UIColor.white.withAlphaComponent(1.0).cgColor
        ]
        mask.locations = [0.2, 0.5, 1.0]
        mask.frame = backgroundImage.bounds
        backgroundImage.layer.mask = mask
    }
    
    func configure(with trip: Trip) {
        titleLabel.text = trip.title
        dateLabel.text = trip.startDate?.dateOnly
        
        if trip.childCount > 0 {
            activityLabel.text = "\(trip.childCount) activities"
        } else {
            activityLabel.text = nil
        }
        
        if let imageString = trip.image, let url = URL(string: imageString) {
            backgroundImage.sd_setImage(with: url)
        }
    }
    
    // MARK: - Render
    
    private func render() {
        renderBackground()
        renderTitle()
        renderDate()
        renderActivity()
        
        contentView.bottomAnchor.constraint(
            equalTo: dateLabel.bottomAnchor,
            constant: 12
        ).isActive = true
    }
    
    private func renderBackground() {
        background.backgroundColor = .white
        background.layer.cornerRadius = 8
        background.layer.shadowColor = UIColor.systemGray.cgColor
        background.layer.shadowOffset = CGSize(width: 0, height: 2)
        background.layer.shadowOpacity = 0.5
        background.layer.shadowRadius = 5
        background.layer.masksToBounds = false
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            background.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            background.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        
        backgroundImage.layer.cornerRadius = 8
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: background.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: background.centerXAnchor, constant: -50),
            backgroundImage.rightAnchor.constraint(equalTo: background.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: background.bottomAnchor),
        ])
    }
    
    private func renderTitle() {
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: background.leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: background.rightAnchor, constant: -8),
        ])
    }
    
    private func renderDate() {
        dateLabel.font = .systemFont(ofSize: 14, weight: .regular)
        dateLabel.textColor = .secondaryLabel
        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: 8),
            dateLabel.leftAnchor.constraint(equalTo: background.leftAnchor, constant: 8),
        ])
    }
    
    private func renderActivity() {
        activityLabel.font = .systemFont(ofSize: 14, weight: .regular)
        activityLabel.textColor = .secondaryLabel
        NSLayoutConstraint.activate([
            activityLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor),
            activityLabel.leftAnchor.constraint(equalTo: dateLabel.leftAnchor),
        ])
    }
}
