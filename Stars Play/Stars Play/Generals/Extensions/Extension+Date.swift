//
//  Extension+Date.swift
//  Stars Play
//
//  Created by Asif Ayub on 16/02/2025.
//

import Foundation

extension Date {
    func format(_ format: String) -> String {
        // Create a DateFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        // Convert the string to a Date
        return dateFormatter.string(from: self)
    }
}
