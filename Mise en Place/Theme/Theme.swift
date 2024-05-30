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

        case "Mint": mintTheme()

        case "Nana": nanaTheme()

        case "Momo": momoTheme()

        case "Rec-Diffs": recDiffsTheme()

        default: defaultTheme()
        }

    }

    static func circleOne(name: String) -> Color {
        switch name {
        case "Default": return Color(UIColor.label)

        case "Blue": return Color(hex: "40679E")

        case "Lilac": return Color(hex:"D3B5E5")

        case "Cherry Blossom": return Color(hex: "FFB7C5")

        case "Forest": return Color(hex: "436850")

        case "Burnt Orange" : return Color(hex: "FF4E00")

        case "Code Green": return Color(hex: "4CBB17")

        case "Sunset": return Color(hex: "FFDD95")

        case "Purple and Pink": return Color(hex: "9B4F96")

        case "Mint": return Color(hex: "DCFFFD")

        case "Nana": return .white

        case "Momo": return Color(hex: "e9e0d4")

        default: return Color(UIColor.label)
        }
    }

    static func circleTwo(name: String) -> Color {
        switch name {
        case "Default": return .primary

        case "Blue": return Color(hex: "1B3C73")

        case "Lilac": return Color(hex: "B785B7")

        case "Cherry Blossom": return Color(hex:"FF9EB0")

        case "Forest": return Color(hex: "12372A")

        case "Burnt Orange" : return Color(hex: "BF3100")

        case "Code Green": return .black

        case "Sunset": return Color(hex:"FF9843")

        case "Purple and Pink": return Color(hex: "D60270")

        case "Mint": return Color(hex: "52FFEE")

        case "Nana": return .orange

        case "Momo": return Color(hex: "D2CAC5")

        default: return .primary
        }
    }

    static func momoTheme() {
        outlines = Color(hex: "D2CAC5")
        interactiveElements = Color(hex: "e9e0d4")
    }

    static func nanaTheme() {
        outlines = .orange
        interactiveElements = .white
        text = .black
    }
    static func codeGreenTheme() {
        outlines = .black
        interactiveElements = Color(hex: "4CBB17")
        text = Color(UIColor.systemBackground)

    }

    static func mintTheme() {
        outlines = Color(hex: "52FFEE")
        interactiveElements = Color(hex: "DCFFFD")
        text = .primary
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

    static func recDiffsTheme() {
        outlines = Color(red: 184/255, green: 70/255, blue: 61/255)
        interactiveElements = Color(red: 78/255, green: 122/255, blue: 152/255)
        text = .primary
    }
}
