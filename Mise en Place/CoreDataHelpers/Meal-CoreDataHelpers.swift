//
//  Meal-CoreDataHelpers.swift
//  Mise en Place
//
//  Created by Tanner King on 11/29/23.
//

import Foundation

extension Meal {

    var mealID: UUID {
        id ?? UUID()
    }

    var mealType: String {
        get { type ?? ""}
        set { type = newValue}
    }

    var mealName: String {
        get { name ?? ""}
        set { name = newValue}
    }

    var mealTime: Date {
        time ?? .distantPast
    }

    var mealTimeString: String {
        let date = time ?? .now
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "EEEE, MMM d"
        return dateFormatter.string(from: date)

    }
}

extension Meal: Comparable {
    public static func <(lhs: Meal, rhs: Meal) -> Bool{
        let left = lhs.mealTime
        let right = rhs.mealTime

        if left == right {
            return lhs.mealID.uuidString < rhs.mealID.uuidString
        } else {
            return left < right
        }
    }
}


