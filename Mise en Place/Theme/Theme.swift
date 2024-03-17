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

        case "Burnt Orange" : burntOrangeTheme()

        case "Code Green": codeGreenTheme()

        case "Sunset": sunsetTheme()

        case "Purple and Pink": purpleAndPinkTheme()

        default: defaultTheme()
        }

    }


    static func codeGreenTheme() {
        outlines = .black
        interactiveElements = Color(hex: "4CBB17")
        text = Color(UIColor.systemBackground)

    }
    static func burntOrangeTheme() {
        outlines = Color(hex: "BF3100")
        interactiveElements = Color(hex: "FF4E00")
        text = .primary
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

    static func sunsetTheme() {
        outlines = Color(hex:"FF9843")
        interactiveElements = Color(hex: "FFDD95")
        text = Color(.black)
    }

    static func purpleAndPinkTheme() {
        outlines = Color(hex: "D60270")
        interactiveElements = Color(hex: "9B4F96")
        text = .primary
    }
}
