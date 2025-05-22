//
//  Date.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 20/05/25.
//

import UIKit

extension Date {
    var dateOnly: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        return formatter.string(from: self)
    }
    
    var timeOnly: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
