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
    static var text = Color.primary
    @EnvironmentObject var dataController: DataController

    static func loadTheme(){
        let defaults = UserDefaults.standard
        let theme = defaults.string(forKey: "Theme")
        switch theme {
        case "Default": defaultTheme()

        case "Blue": blueTheme()

        case "Lilac": lilacTheme()

        case "Cherry Blossom": cherryBlossomTheme()

        case "Forest": forestTheme()

        default: defaultTheme()
        }

    }



    static func blueTheme() {
        outlines = Color(hex: "1B3C73")
        interactiveElements = Color(hex: "40679E")
        text = .white
    }

    static func lilacTheme() {
        outlines = Color(hex: "B785B7")
        interactiveElements = Color(hex:"D3B5E5")
        text = .primary
    }

    static func cherryBlossomTheme() {
        outlines = Color(hex:"FF9EB0")
        interactiveElements = Color(hex: "FFB7C5")
        text = .primary
    }

    static func forestTheme() {
        outlines = Color(hex: "12372A")
        interactiveElements = Color(hex: "436850")
        text = .primary
    }

    static func defaultTheme() {
        outlines = .primary
        interactiveElements = Color(UIColor.label)

        text = Color(UIColor.systemBackground)

    }
}
