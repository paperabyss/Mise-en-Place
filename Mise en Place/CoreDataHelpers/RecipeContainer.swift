//
//  RecipeContainer.swift
//  Mise en Place
//
//  Created by Tanner King on 3/19/24.
//

import Foundation

class RecipeContainer: Codable {
    let recipe: Recipe

    init(recipe: Recipe) {
        self.recipe = recipe
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let cookingHours = try container.decode(Int16.self, forKey: .cookingHours)
        let cookingMinutes = try container.decode(Int16.self, forKey: .cookingMinutes)
        let cookingTime = try container.decode(Int16.self, forKey: .cookingTime)
        let creationDate = try container.decode(Date.self, forKey: .creationDate)
        let id = try container.decode(UUID.self, forKey: .id)
        let information = try container.decode(String.self, forKey: .information)
        let instructions = try container.decode(String.self, forKey: .instructions)
        let lastMade = try container.decode(Date.self, forKey: .lastMade)
        let servings = try container.decode(Double.self, forKey: .lastMade)
        let title = try container.decode(String.self, forKey: .title)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(recipe.cookingHours, forKey: .cookingHours)
        try container.encode(recipe.cookingMinutes, forKey: .cookingMinutes)
        try container.encode(recipe.cookingTime, forKey: .cookingTime)
        try container.encode(recipe.creationDate, forKey: .creationDate)
        try container.encode(recipe.id, forKey: .id)
        try container.encode(recipe.information, forKey: .information)
        try container.encode(recipe.instructions, forKey: .instructions)
        try container.encode(recipe.lastMade, forKey: .lastMade)
        try container.encode(recipe.servings, forKey: .lastMade)
        try container.encode(recipe.title, forKey: .title)
    }

    enum CodingKeys: String, CodingKey {
        case cookingHours
        case cookingMinutes
        case cookingTime
        case creationDate
        case difficulty
        case id
        case information
        case instructions
        case lastMade
        case servings
        case storedImage
        case title
    }


}
