//
//  String.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 20/05/25.
//

import Foundation

extension String {
    var toDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: self)
    }
}
