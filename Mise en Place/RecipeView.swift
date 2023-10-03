//
//  RecipeView.swift
//  Mise en Place
//
//  Created by Tanner King on 9/18/23.
//

import SwiftUI

struct RecipeView: View {
    @EnvironmentObject var dataContoller: DataController
    @ObservedObject var recipe: Recipe
    @State private var editEnabled = false
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image("testPie")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.teal)
                        )

                    VStack {
                        if editEnabled {TextField("Recipe Title", text:$recipe.recipeTitle)
                                .disabled(!editEnabled)
                                .font(.title)
                                .padding(.vertical)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.teal)
                                )
                            }

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
            .padding()
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
            .padding()
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
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.teal)
            )
        }
        .navigationTitle(recipe.recipeTitle)
        .toolbar {
            Button("Edit") {
                editEnabled.toggle()
            }
        }
        .onReceive(recipe.objectWillChange) { _ in
            dataContoller.queueSave()
        }
        .onAppear {
            dataContoller.selectedRecipe = recipe
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: Recipe.example)
    }
}
