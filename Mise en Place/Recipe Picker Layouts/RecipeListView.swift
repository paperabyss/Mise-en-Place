//
//  RecipeListView.swift
//  Mise en Place
//
//  Created by Tanner King on 9/18/23.
//

import SwiftUI

struct RecipeListView: View {
    let recipes: [Recipe]

    var body: some View {
        ScrollView {
                ForEach(recipes) { recipe in
                    NavigationLink {
                        RecipeView(recipe: recipe)
                    } label: {
                        HStack {
                            Text(recipe.recipeTitle)
                                .padding()
                                .font(.title)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.red)

                            VStack {
                                Text("\(recipe.cookingTime) minutes")
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Text(recipe.recipeDifficultyString)
                                    .font(.headline)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(width: 150, height: 100)
                            .background(.blue)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue)
                        .accessibilityAddTraits(.isButton)
                        .accessibilityElement()
                        .accessibilityValue(recipe.recipeTitle)
                        )
                    }
                }
            .padding([.horizontal, .bottom])
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(recipes: [])
    }
}
