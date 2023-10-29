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
    private let frameHeight: CGFloat = 160


    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Recipe Information")) {
                    VStack(alignment: .leading) {

                        //Title
                        Text("Title:")
                            .font(.headline)
                        TextField("Title", text: $recipe.recipeTitle, prompt: Text("Enter ther recipe title here"))

                        //Servings
                        Divider()
                        Stepper("Servings: \(Int(recipe.servings))", value: $recipe.servings, in: 1...16 )


                        //Time to Make
                        Divider()
                        GeometryReader { geometry in
                                    HStack(spacing: 0) {

                                        Text("Cooking Time:")
                                            .lineLimit(nil)

                                        Spacer()

                                        Picker(selection: $recipe.recipeHours, label: Text("")) {
                                            ForEach(0..<24) {
                                                Text("\($0) h").tag(Int16($0))
                                            }
                                        }
                                        .frame(width: geometry.size.width/4, height: geometry.size.height, alignment: .center)
                                        .clipped()

                                        Picker(selection: $recipe.recipeMinutes, label: Text("")) {
                                            ForEach(0..<59) {
                                                Text("\($0) m").tag(Int16($0))
                                            }
                                        }
                                        .onSubmit {
                                            dataController.save()
                                        }
                                        .frame(width: geometry.size.width/4, height: geometry.size.height, alignment: .center)
                                        .clipped()
                                    }
                                }

                        //Difficulty of Recipe
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

                Section(header:Text("Description")) {
                    //Description of Recipe
                    Text("Description:")
                        .font(.headline)
                    TextField("Description", text: $recipe.recipeInformation, axis: .vertical)
                }

                Section(header: Text("Ingredients")) {
                    ForEach(recipe.recipeIngredients) { ingredient in
                        NavigationLink {
                            IngredientEditor(ingredient: ingredient)
                        } label: {
                            Text(ingredient.ingredientName)
                        }
                    }
                    .onDelete(perform: deleteIngredient)

                    Button("Add an Ingredient"){
                        dataController.newIngredient(recipe: recipe)
                    }
                }

                Section(header: Text("Directions")) {
                    ForEach(recipe.recipeSteps) { step in
                        NavigationLink {
                            StepEditor(step: step)
                        } label: {
                            HStack{
                                Text (String(Int(step.number)))
                                Text (step.stepInstruction)
                            }
                        }
                    }
                    .onDelete(perform: deleteStep)
                    Button("Add an instruction."){
                        dataController.newStep(recipe: recipe)
                        isEditing.toggle()
                    }
                }
            }
        }
    }

    func deleteIngredient(_ offsets: IndexSet) {
        let ingredients = recipe.ingredients?.allObjects as! [Ingredient]
        for offset in offsets {
            let item = ingredients[offset]
            dataController.delete(item)
        }
    }

    func deleteStep(_ offsets: IndexSet) {
        let steps = recipe.steps?.allObjects as! [Step]
        for offset in offsets {
            let item = steps[offset]
            dataController.delete(item)
        }
    }
}


