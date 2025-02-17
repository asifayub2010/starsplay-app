//
//  Extension+String.swift
//  Stars Play
//
//  Created by Asif Ayub on 16/02/2025.
//

import Foundation

extension String {
    var toDate: Date? {
        // Create a DateFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Set the format of the input string

        // Convert the string to a Date
        return dateFormatter.date(from: self)
    }
}
