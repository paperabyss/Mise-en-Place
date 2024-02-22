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
                         //   .shadow(color: Color("ColorBlackTransparentLight"), radius: 8,x: 0, y:0 )
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
                           // .shadow(color: Color("ColorBlackTransparentLight"), radius: 8,x: 0, y:0 )
                        }
                    }

                    Spacer()

                    VStack {
                        HStack {
                            Text("\(recipe.cookingHours)H")
                            Text("\(recipe.cookingMinutes)M")
                        }

                        Text(recipe.recipeServings)

                        Text(recipe.recipeDifficultyString)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.secondary)
                        )
                    .padding()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.secondary)
                )
                .padding()
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
                            .foregroundStyle(.red)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.pink)
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
                                .stroke(.pink)
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
            if !fromMealPlanner {
                Button("Add to a meal.") {
                    showingMealPlanner.toggle()
                }
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
