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

            //Start of Picture and Title Block
            VStack {

                //Color Background
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

                    //Picture / Picture Picker
                    HStack {
                        Spacer()
                        if recipe.recipeStoredImage != nil { // If an there is an image for the recipe, this box will be filled with the picture.
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
                            // If there is no picture, the app will display a blue box that, when clicked, allows the user to pick an image.
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
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Theme.outlines)
                                        )
                                    Text("Select an Image")
                                        .foregroundStyle(Theme.text)
                                        .fontWeight(.bold)
                                }
                                .accessibilityElement()
                                .accessibilityLabel("Add an Image")
                            }
                        }

                        Spacer()
                        
                        VStack {

                            //Start of cooking time block
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
                            //End of cooking time block

                            //Start of servings block.
                            VStack {
                                Text("Servings:")
                                    .font(.footnote)
                                Text(recipe.recipeServings)
                            }
                            .accessibilityElement()
                            .accessibilityLabel( "\(recipe.recipeServings) servings")
                            //End of servings block.

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

                //Start of about description.
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



                //Start of Ingredients block
                VStack {
                    HStack {
                        Text("Ingredients:")
                            .font(.title2)
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
                                .stroke(Theme.outlines)
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
                //End of Ingredients Lis

                //Start of Instructions block
                VStack {
                    HStack{
                        Text("Instructions:")
                            .font(.title2)
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
                        VStack{
                            Text(recipe.recipeInstructions)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Theme.outlines)
                        )
                    }}

                .padding()
            }
            //End of Instructions block.
        }
        .navigationTitle(recipe.recipeTitle)

        
        .toolbar {
            Button(!editEnabled ? "Edit" : "Stop Editing") {
                editEnabled.toggle()
            }
            Button("IngredientListPrint") {
                print(recipe.ingredientList)
                print(recipe.recipeIngredientsList)
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
