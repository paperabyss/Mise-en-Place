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
                        Text("Title:")
                            .font(.headline)
                        TextField("Title", text: $recipe.recipeTitle, prompt: Text("Enter ther recipe title here"))

                        //Servings
                        Divider()
                        Stepper("Servings: \(Int(recipe.servings))", value: $recipe.servings, in: 1...16 )
                    }
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
                }

                //Difficulty of Recipe
                Section(header: Text("Difficulty")) {
                    Picker("Recipe Difficulty", selection: $recipe.difficulty) {
                        Text("Easy").tag(Int16(0))
                        Text("Medium").tag(Int16(1))
                        Text("Hard").tag(Int16(2))
                    }
                }



                //Description of Recipe
                Section(header:Text("Description")) {
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


                //Directions for Recipe
                Section(header: Text("Directions")) {
                    List{
                        ForEach(recipe.recipeSteps) { step in
                            let index = recipe.recipeSteps.firstIndex(of:step)
                            // NavigationLink {
                                // StepEditor(step: step)
                             Button {
                                 print(index)
                            } label: {
                                HStack{
                                    Text (String(Int(step.number)))
                                    Text (step.stepInstruction)
                                }
                                .onTapGesture {
                                    print(index)
                                }
                            }
                        }
                        .onMove(perform: moveStep)
                        .onDelete(perform: deleteStep)
                        Button("Add an instruction."){
                            dataController.newStep(recipe: recipe)
                            isEditing.toggle()
                        }
                    }
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

    func moveStep(at sets: IndexSet, destination: Int){
        viewContext.perform {
            let itemToMove = sets.first!
            print ("Grabbed item at index \(itemToMove)")

            if itemToMove < destination{
                var startIndex = itemToMove + 1
                let endIndex = destination - 1
                var startOrder = recipe.recipeSteps[itemToMove].stepNumber
                while startIndex <= endIndex{
                    recipe.recipeSteps[startIndex].stepNumber = startOrder
                    startOrder = startOrder + 1
                    startIndex = startIndex + 1
                }
                recipe.recipeSteps[itemToMove].stepNumber = startOrder
            }
            else if destination < itemToMove{
                var startIndex = destination
                let endIndex = itemToMove - 1
                var startOrder = recipe.recipeSteps[destination].stepNumber + 1
                let newOrder = recipe.recipeSteps[destination].stepNumber
                while startIndex <= endIndex{
                    recipe.recipeSteps[startIndex].stepNumber = startOrder
                    startOrder = startOrder + 1
                    startIndex = startIndex + 1
                }
                recipe.recipeSteps[itemToMove].number = newOrder
            }

            dataController.save()

        }
        dataController.save()
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

