//
//  TagsMenuView.swift
//  Mise en Place
//
//  Created by Tanner King on 5/16/24.
//

import SwiftUI

struct TagsMenuView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var recipe: Recipe
    @State private var showingAddTag = false
    @State private var name = ""

    var body: some View {
        Menu {
            // show selected tags first
            ForEach(recipe.recipeTags) { tag in
                Button {
                    recipe.removeFromTags(tag)
                } label: {
                    Label(tag.tagName, systemImage: "Checkmark")
                }
            }

            // now show unselected tags
            let otherTags = dataController.missingTags(from: recipe)

            if otherTags.isEmpty == false {
                Divider()

                Section("Add Tags") {
                    ForEach(otherTags) { tag in
                        Button(tag.tagName) {
                            recipe.addToTags(tag)
                        }
                    }
                }
            }
        } label: {
            Text(recipe.recipeTagsList)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .animation(nil, value: recipe.recipeTagsList)
        }
        Button("Enter Tag Name") {
            showingAddTag.toggle()
        }
        .alert("Enter the name of the tag", isPresented: $showingAddTag) {
            TextField("Enter your tag name", text: $name)
            Button("OK"){
                dataController.createNewTagandAddtoRecipe(recipe: recipe, name: name)
            }
        }
    }
}

struct TagsMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TagsMenuView(recipe: .example)
            .environmentObject(DataController(inMemory: true))
    }
}
