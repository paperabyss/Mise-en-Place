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
    @State private var showingImagePicker = false
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    if recipe.recipeStoredImage != nil {
                        Image(uiImage: recipe.recipeStoredImage!)
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
                            .frame(width: 150,
                                   height: 150
                                    )
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        Button() {
                            showingImagePicker.toggle()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .scaledToFill()
                                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
                                    .frame(width: 150,
                                           height: 150
                                            )
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                Text("Select an Image")
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                            }
                        }
                    }

                    Spacer()

                        Text(recipe.recipeTitle)
                                .font(.headline)
                                .padding(.vertical)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.teal)
                                )
                                .padding()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.teal)
                )
                .padding()
                //End of Picture and Title Block


                VStack {
                    HStack {
                        Text("\(recipe.cookingHours)H")
                        Text("\(recipe.cookingMinutes)S")
                    }

                    Text(recipe.recipeServings)

                    Text(recipe.recipeDifficultyString)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.teal)
                    )
                .padding()
                //End of Basic Info

                VStack {
                    Text("Description:")
                        .font(.headline)
                    Spacer()
                    Text(recipe.recipeInformation)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.teal)
                )
                .padding()
                //End of Description

                VStack {

                    Text("Ingredients:")
                        .font(.headline)
                    ForEach(recipe.recipeIngredients) { ingredient in
                        Text(ingredient.ingredientName)
                    }

                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.teal)
                )
                .padding()
                //End of Ingredients Lis

                VStack {
                    Text("Instructions")
                        .font(.headline)

                    ForEach(recipe.recipeSteps) { step in
                        HStack {
                            Text(String(Int(step.number)))
                            Text(step.stepInstruction)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.teal)
                )
                .padding()
            }


        }
        .navigationTitle(recipe.recipeTitle)
        .toolbar {
            Button(!editEnabled ? "Edit" : "Stop Editing") {
                editEnabled.toggle()
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $recipe.recipeStoredImage)
        }
        .sheet(isPresented: $editEnabled){
            New_EditRecipeView(recipe: recipe)
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
