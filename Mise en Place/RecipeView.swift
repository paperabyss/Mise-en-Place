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
                    if recipe.recipeStoredImage != nil {
                        Image(uiImage: recipe.recipeStoredImage!)
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
                            .frame(width: 150,
                                   height: 150
                                    )
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.teal)
                            )
                            .onTapGesture {
                                showingImagePicker = true
                            }
                            .disabled(!editEnabled)
                    } else {
                        Button("Select Image") {
                            showingImagePicker.toggle()
                        }
                    }


                    VStack {
                        TextField("Recipe Title", text:$recipe.recipeTitle)
                                .disabled(!editEnabled)
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
            Button(!editEnabled ? "Edit" : "Stop Editing") {
                editEnabled.toggle()
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $recipe.recipeStoredImage)
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
