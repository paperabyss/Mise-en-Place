//
//  DateExtentions.swift
//  Mise en Place
//
//  Created by Tanner King on 2/26/24.
//

import Foundation
extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}
