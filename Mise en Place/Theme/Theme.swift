//
//  Theme.swift
//  Mise en Place
//
//  Created by Tanner King on 2/22/24.
//

import Foundation
import SwiftUI

struct Theme {
    static var themePrimaryColor = Color.primary
    static var themeSecondaryColor = Color.primary
    static var outlines = Color.primary
    static var interactiveElements = Color.primary


    static func themeBlue() {
        themePrimaryColor = Color.blue
        themeSecondaryColor = Color.teal
    }

    static func lilacTheme() {
        outlines = Color(hex: "bfacc8")
        interactiveElements = Color(hex:"783F8E")
    }
}
