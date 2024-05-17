//
//  New:EditRecipeView.swift
//  Mise en Place
//
//  Created by Tanner King on 10/16/23.
//

import SwiftUI

struct New_EditRecipeView: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @ObservedObject var recipe: Recipe
    @State private var isEditing = false
    private let frameHeight: CGFloat = 160
    @State private var showingImagePicker = false


    var body: some View {
        @State var steps = recipe.recipeSteps
        NavigationView{


            Form {


                //Image Picker
                Section{
                    VStack(alignment: .trailing){
                        if recipe.recipeStoredImage != nil {
                            Button() {
                                showingImagePicker.toggle()
                            } label: {
                                Image(uiImage: recipe.recipeStoredImage!)
                                    .resizable()
                                    .scaledToFill()
                                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
                                    .frame(width: 150,
                                           height: 150
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
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
                    }
                }

                //Recipe Information
                Section(header: Text("Recipe Information")) {
                    VStack(alignment: .leading) {

                        //Title
                        HStack {
                            Text("Title:")
                                .font(.headline)
                            TextField("Title", text: $recipe.recipeTitle, prompt: Text("Enter ther recipe title here"))
                        }

                        //Servings
                        Divider()
                        Stepper("Servings: \(Int(recipe.servings))", value: $recipe.servings, in: 1...16 )

                    }

                    TagsMenuView(recipe: recipe)
                }

                //Time to Make
                Section(header: Text("Time to Make")){
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
                            .accessibilityLabel("Hours")
                            .accessibilityInputLabels(["Hours", "Cooking Hours"])
                            .frame(width: geometry.size.width/4, height: geometry.size.height, alignment: .center)
                            .clipped()

                            Picker(selection: $recipe.recipeMinutes, label: Text("")) {
                                ForEach(0..<59) {
                                    Text("\($0) m").tag(Int16($0))
                                }
                            }
                            .accessibilityLabel("Minutes")
                            .accessibilityInputLabels(["Minutes, Cooking Minutes"])
                            .onSubmit {
                                dataController.save()
                            }
                            .frame(width: geometry.size.width/4, height: geometry.size.height, alignment: .center)
                            .clipped()
                        }
                    }
                }

                //Difficulty of Recipe
                Section(header: Text("Difficulty")) {
                    Picker("Recipe Difficulty", selection: $recipe.recipeDifficulty) {
                        ForEach(dataController.difficulties, id: \.self) {
                            Text($0)
                        }
                    }
                }



                //Description of Recipe
                Section(header:Text("Description")) {
                    TextField("Description", text: $recipe.recipeInformation, axis: .vertical)
                }

                Section(header: Text("Ingredients")) {
                    ForEach(recipe.recipeIngredients) { ingredient in
                     
                            IngredientEditor(ingredient: ingredient)

                    }
                    .onDelete(perform: deleteIngredient)

                    Button("Add an Ingredient"){
                        dataController.newIngredient(recipe: recipe)
                    }
                }


                //Directions for Recipe
                Section(header: Text("Directions")) {
                    TextField("How to cook this recipe:", text: $recipe.recipeInstructions, axis: .vertical)
                }
            }
            .navigationTitle("Editing")
            .toolbar {
                Button() {
                    dataController.save()
                    dismiss()
                } label: {
                Label("Save and Close",systemImage: "folder.badge.plus")
                }
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $recipe.recipeStoredImage) }
    }

    func deleteIngredient(_ offsets: IndexSet) {
        let ingredients = recipe.recipeIngredients
        for offset in offsets {
            let item = ingredients[offset]
            dataController.delete(item)
        }
    }
    func deleteStep(_ offsets: IndexSet) {
        withAnimation{
            let steps = recipe.recipeSteps
            for offset in offsets {
                let item = steps[offset]
                dataController.delete(item)
            }
        }
    }
}


