//
//  RecipeGridView.swift
//  Mise en Place
//
//  Created by Tanner King on 9/18/23.
//

import SwiftUI

struct RecipeGridView: View {
    @EnvironmentObject var dataController: DataController

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {

        let recipes: [Recipe] = dataController.recipesForSelectedFilter()

        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(recipes) { recipe in
                    NavigationLink {
                        RecipeView(recipe: recipe )
                    } label: {
                        VStack {
                            Image("testPie")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()

                            VStack {
                                Text(recipe.recipeTitle)
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Text(recipe.recipeDifficultyString)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.teal)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.teal)
                        )
                        .accessibilityAddTraits(.isButton)
                        .accessibilityElement()
                        .accessibilityValue(recipe.recipeTitle)
                        .accessibilityHint(recipe.recipeDifficultyString)
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct RecipeGridView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeGridView()
    }
}
