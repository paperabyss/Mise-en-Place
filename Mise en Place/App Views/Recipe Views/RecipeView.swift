//
//  RecipeView.swift
//  Mise en Place
//
//  Created by Tanner King on 9/18/23.
//

import SwiftUI

struct RecipeView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var recipe: Recipe
    @State private var fromMealPlanner: Bool = false
    @State private var editEnabled = false
    @State private var showingMealPlanner = false
    @State private var showingImagePicker = false
    @State private var showingShareSheet = false
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(0.3)
                        .foregroundStyle(Theme.interactiveElements)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Theme.outlines)
                                .opacity(0.3)
                        )
                        .padding()
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
                                .accessibilityHidden(true)
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
                                .accessibilityElement()
                                .accessibilityLabel("Add an Image")
                            }
                        }

                        Spacer()

                        VStack {
                            VStack {
                                Text("Cooking Time:")
                                    .font(.footnote)
                                HStack {
                                    Text("\(recipe.cookingHours)H")
                                    Text("\(recipe.cookingMinutes)M")
                                }
                            }
                            .accessibilityElement()
                            .accessibilityLabel("The cooking time is \(recipe.cookingHours) hours and \(recipe.cookingMinutes) minutes.")

                            VStack {
                                Text("Servings:")
                                    .font(.footnote)
                                Text(recipe.recipeServings)
                            }
                            .accessibilityElement()
                            .accessibilityLabel( "\(recipe.recipeServings) servings")

                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Theme.outlines)
                        )
                        .padding(1)
                    }

                    .padding()
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Theme.outlines)
                    )
                    .padding()
                }
                //End of Picture and Title Block



                //End of Basic Info
                VStack {
                    HStack {
                        Text("About:")
                            .font(.title2)
                            .foregroundStyle(.primary)
                        Spacer()
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .opacity(0.3)
                            .foregroundStyle(Theme.interactiveElements)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Theme.outlines)
                                    .opacity(0.3)
                            )
                        VStack {
                            Text(recipe.recipeInformation)
                                .foregroundStyle(.primary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Theme.outlines)
                        )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                //End of Description


                VStack {
                    HStack {
                        Text("Ingredients:")
                            .font(.title2)
                        Spacer()
                    }
                    VStack{
                        ForEach(recipe.recipeIngredients) { ingredient in
                            HStack {
                                Text(ingredient.ingredientName)
                                    .font(.headline)
                                Text(
                                    "\(Int(ingredient.massValue)) \(ingredient.ingredientMassUnit)\(ingredient.massValue > 1 ? "s": "")")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.secondary)
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)

                }

                .padding()
                //End of Ingredients Lis

                VStack {
                    HStack{
                        Text("Instructions:")
                            .font(.title2)
                        Spacer()
                    }
                    VStack{
                        Text(recipe.recipeInstructions)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.secondary)
                    )
                }

                .padding()
            }


        }
        .navigationTitle(recipe.recipeTitle)

        
        .toolbar {
            Button(!editEnabled ? "Edit" : "Stop Editing") {
                editEnabled.toggle()
            }
            Button("Export") {
                dataController.exportRecipe(recipe: recipe)
//                dataController.convertToJSONArray(moArray: [recipe])
            }

            Button("Print Value"){
                print(recipe.id)
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $recipe.recipeStoredImage)
        }
        .sheet(isPresented: $editEnabled){
            New_EditRecipeView(recipe: recipe)
        }

        .onReceive(recipe.objectWillChange) { _ in
            dataController.queueSave()
        }
        .onAppear {
            dataController.selectedRecipe = recipe
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: Recipe.example)
    }
}
