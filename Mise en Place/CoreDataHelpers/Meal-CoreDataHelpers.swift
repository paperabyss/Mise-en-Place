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
        let mealTypes = ["Breakfast", "Lunch", "Dinner"]
        return type ?? mealTypes[Int.random(in: 0...2)]
    }

    var mealName: String {
        name ?? type ?? "Food"
    }

    var mealTime: Date {
        time ?? .distantPast
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
