//
//  RecipeView.swift
//  Mise en Place
//
//  Created by Tanner King on 9/18/23.
//

import SwiftUI

struct RecipeView: View {
    let recipe: Recipe
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image("testPie")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.teal)
                        )

                    VStack {
                        Text(recipe.recipeTitle)
                            .font(.title)
                            .padding(.vertical)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.teal)
                            )
                            Spacer()
                        HStack {
                            Text(recipe.recipeTimeToMakeString)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.teal)
                                )
                            VStack {
                                Text(recipe.recipeServings)
                                Text(recipe.recipeDifficultyString)
                            }
                            .font(.subheadline)
                            .padding(.horizontal)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.teal)
                            )
                        }
                        Spacer()
                    }
                    .padding()
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.teal)
                )
            }
            VStack{
                Text("Description:")
                    .font(.headline)
                Spacer()
                Text(recipe.recipeInformation)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.teal)
            )

            VStack {
                ForEach(recipe.recipeIngredients) { ingredient in
                    Text(ingredient.ingredientName)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.teal)
            )

            VStack {
                ForEach(recipe.recipeSteps) { step in
                    HStack {
                        Text(String(Int(step.number)))
                        Text(step.stepInstruction)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.teal)
            )
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: Recipe.example)
    }
}
