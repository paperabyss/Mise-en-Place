//
//  Ingredient-CoreDataHelpers.swift
//  Mise en Place
//
//  Created by Tanner King on 9/5/23.
//

import Foundation

extension Ingredient {
    var ingredientName: String {
        get { name ?? ""}
        set { name = newValue}
    }

    var ingredientID: UUID {
        id ?? UUID()
    }

    var ingredientMassUnit: String {
        get { massUnit ?? ""}
        set { massUnit = newValue}
    }

//    var ingredientRecipes: [Recipe] {
//        let result = recipes?.allObjects as? [Recipe] ?? []
//        return result.sorted()
//    }

    static var example: Ingredient {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext

        let ingredient = Ingredient(context: viewContext)
        ingredient.name = "Example Ingredient"
        ingredient.massUnit = "grams"
        ingredient.massValue = 1.1
        return ingredient
    }
}

extension Ingredient: Comparable {
    public static func <(lhs: Ingredient, rhs: Ingredient) -> Bool{
        let left = lhs.ingredientName
        let right = rhs.ingredientName

        if left == right {
            return lhs.ingredientID.uuidString < rhs.ingredientID.uuidString
        } else {
            return lhs < rhs
        }
    }
}
