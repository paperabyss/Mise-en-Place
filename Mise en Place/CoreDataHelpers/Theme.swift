//
//  Theme.swift
//  Mise en Place
//
//  Created by Tanner King on 2/22/24.
//

import Foundation
import SwiftUI

struct Theme {
    static var themePrimaryColor = Color.blue
    static var themeSecondaryColor = Color.red

    static func themeBlue() {
        themePrimaryColor = Color.blue
        themeSecondaryColor = Color.teal
    }
}
