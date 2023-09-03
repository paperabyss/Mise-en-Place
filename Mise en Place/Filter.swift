//
//  Filter.swift
//  Mise en Place
//
//  Created by Tanner King on 8/29/23.
//

import Foundation

struct Filter: Identifiable, Hashable {
    var id: UUID
    var name: String
    var icon: String
    var lastMadeDate: Date?
    var tag: Tag?

    static var all = Filter(id: UUID(), name: "All Recipes", icon: "tray")
    static var recent = Filter(id: UUID(), name: "Recently Made Recipes", icon: "clock", lastMadeDate: .now.addingTimeInterval(86400 * -14))

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: Filter, rhs: Filter) -> Bool {
        lhs.id == rhs.id
    }
}
