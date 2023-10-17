//
//  New:EditRecipeView.swift
//  Mise en Place
//
//  Created by Tanner King on 10/16/23.
//

import SwiftUI

struct New_EditRecipeView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var recipe: Recipe
    @State private var isEditing = false

    var body: some View {
        Form {
            Section(header: Text("Recipe Information")) {
                VStack(alignment: .leading) {
                    Text("Title:")
                        .font(.headline)
                    TextField("Title", text: $recipe.recipeTitle, prompt: Text("Enter ther recipe title here"))
                    
//                    Stepper("Servings", value: $recipe.recipeServings, in: 1...16 )

                    Divider()
                    Text("Description:")
                        .font(.headline)
                    TextField("Description", text: $recipe.recipeInformation, axis: .vertical)

                    Divider()
                    Text("Difficulty:")
                        .font(.headline)
                    Picker("Recipe Difficulty", selection: $recipe.difficulty) {
                        Text("Easy").tag(Int16(0))
                        Text("Medium").tag(Int16(1))
                        Text("Hard").tag(Int16(2))
                    }
                }
            }
            
            Section(header: Text("Ingredients")) {
                ForEach(recipe.recipeIngredients) { ingredient in
                    Text(ingredient.ingredientName)
                }
                Button("Add an Ingredient"){
                    dataController.newIngredient(recipe: recipe)
                }
            }
            
            Section(header: Text("Directions")) {
                ForEach(recipe.recipeSteps) { step in
                    HStack {
                        Text(String(Int(step.number)))
//                        TextField("Instruction", text: step.stepInstr, axis: .vertical)
                    }
                }
                Button("Add an instruction."){
                    dataController.newStep(recipe: recipe)
                    isEditing.toggle()
                }
            }
        }
    }
}


