//
//  TripPlaceViewCell.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 20/05/25.
//

import UIKit

class TripPlaceViewCell: UITableViewCell {
    static let identifier = "TripPlaceViewCell"
    
    private lazy var activityName: UILabel = UILabel().parent(to: contentView)
    private lazy var durationLabel: UILabel = UILabel().parent(to: contentView)
    private lazy var locationView: ImageAndText = ImageAndText().parent(to: contentView)
    private lazy var dateView: ImageAndText = ImageAndText().parent(to: contentView)
    
    func configure(with tripPlace: TripPlace) {
        activityName.text = tripPlace.name
        durationLabel.attributedText = generateDurationLabel(tripPlace)
        
        if let locationName = tripPlace.location?.name {
            locationView.isHidden = false
            locationView.configure(image: .init(systemName: "mappin"), text: locationName)
        } else {
            locationView.isHidden = true
        }
        
        if let date = generateDateLabelFrom(tripPlace) {
            dateView.isHidden = false
            dateView.configure(image: .init(systemName: "clock"), text: date)
        } else {
            dateView.isHidden = true
        }
        
        render()
    }
    
    private func render() {
        let padding: UIEdgeInsets = .init(top: 16, left: 20, bottom: 16, right: 16)
        
        durationLabel.font = .systemFont(ofSize: 17, weight: .medium)
        durationLabel.numberOfLines = 0
        durationLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            durationLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            durationLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -padding.right),
            durationLabel.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        activityName.font = .systemFont(ofSize: 17, weight: .medium)
        NSLayoutConstraint.activate([
            activityName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding.top),
            activityName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding.left),
            activityName.rightAnchor.constraint(equalTo: durationLabel.leftAnchor, constant: 8),
        ])
        
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: activityName.bottomAnchor, constant: 4),
            locationView.leftAnchor.constraint(equalTo: activityName.leftAnchor),
            locationView.rightAnchor.constraint(equalTo: activityName.rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            dateView.topAnchor.constraint(equalTo: locationView.bottomAnchor, constant: 4),
            dateView.leftAnchor.constraint(equalTo: activityName.leftAnchor),
            dateView.rightAnchor.constraint(equalTo: activityName.rightAnchor),
            
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: dateView.bottomAnchor, constant: padding.bottom),
        ])
    }
    
    private func generateDurationLabel(_ tripPlace: TripPlace) -> NSAttributedString {
        let startDate = tripPlace.startDate ?? Date()
        let endDate = tripPlace.endDate ?? Date()
        let duration = Int(endDate.timeIntervalSince(startDate))
        
        let attributedText = NSMutableAttributedString(
            string: "\(duration / 60)",
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .regular),
            ]
        )
        attributedText.append(NSAttributedString(
            string: "\nminutes",
            attributes: [
                .font: UIFont.systemFont(ofSize: 12, weight: .regular),
            ]
        ))
        
        return attributedText
    }
    
    private func generateDateLabelFrom(_ tripPlace: TripPlace) -> String? {
        guard let startDate = tripPlace.startDate, let endDate = tripPlace.endDate else { return nil }
        return "\(startDate.timeOnly) - \(endDate.timeOnly)"
    }
}
