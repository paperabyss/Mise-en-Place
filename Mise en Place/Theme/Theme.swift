//
//  Theme.swift
//  Mise en Place
//
//  Created by Tanner King on 2/22/24.
//

import Foundation
import SwiftUI

struct Theme {
    static var outlines = Color.primary
    static var interactiveElements = Color.primary

    static func loadTheme(theme: String){
        switch theme {
        case "lilac": lilacTheme()

        case "blue": blueTheme()

        default: defaultTheme()
        }

    }



    static func blueTheme() {
        outlines = Color(hex: "0E9594")
        interactiveElements = Color(hex: "127475")
    }

    static func lilacTheme() {
        outlines = Color(hex: "bfacc8")
        interactiveElements = Color(hex:"783F8E")
    }

    static func defaultTheme() {
        outlines = .primary
        interactiveElements = .secondary
    }
}
