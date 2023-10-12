//
//  Recipe-CoreDataHelpers.swift
//  Mise en Place
//
//  Created by Tanner King on 9/5/23.
//

import Foundation
import UIKit
import SwiftUI

extension Recipe {
    var recipeTitle: String {
        get { title ?? ""}
        set { title = newValue}
    }

    var recipeStoredImage: UIImage? {
        get {
            if storedImage != nil{
                let image = UIImage(data: storedImage!)
                return image
            }
            return nil}

        set { storedImage = newValue?.jpegData(compressionQuality: 1) }
    }

    var recipeInformation: String {
        get { information ?? ""}
        set { information = newValue}
    }

    var recipeCreationDate: Date {
        creationDate ?? .now
    }

    var recipeLastMade: Date {
        lastMade ?? .now
    }

    var recipeTags: [Tag] {
        let result = tags?.allObjects as? [Tag] ?? []
        return result.sorted()
    }

    var recipeIngredients: [Ingredient] {
        let result = ingredients?.allObjects as? [Ingredient] ?? []
        return result.sorted()
    }

    var recipeSteps: [Step] {
        let result = steps?.allObjects as? [Step] ?? []
        return result.sorted()
    }

    var recipeDifficultyString: String {
        switch difficulty{
        case 0:
            return "Easy"

        case 1:
            return "Medium"

        case 2:
            return "Hard"

        default:
            return ""
        }
    }

    var recipeServings: String {
        return "\(String(format: "%g", servings)) servings"
    }


    var recipeTimeToMakeString: String {
        func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
            return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        }
        let (h,m,s) = secondsToHoursMinutesSeconds(Int(cookingTime))

        if h > 0 {
            return ("\(h) H \(m) M \(s) S")
        } else if m > 0 {
            return ("\(m) M, \(s) S")
        }
        return ("\(s) S")
    }


    static var example: Recipe {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext

        let recipe = Recipe(context: viewContext)
        recipe.title = "Example Recipe"
        recipe.information = "This is an example recipe"
        recipe.creationDate = .now
        recipe.cookingTime = 3600
        recipe.difficulty = 0
        recipe.lastMade = .now
        return recipe
    }
}

extension Recipe: Comparable {
    public static func <(lhs: Recipe, rhs: Recipe) -> Bool{
        let left = lhs.recipeTitle.localizedLowercase
        let right = rhs.recipeTitle.localizedLowercase

        if left == right {
            return lhs.recipeCreationDate < rhs.recipeCreationDate
        } else {
            return left < right
        }
    }
}
