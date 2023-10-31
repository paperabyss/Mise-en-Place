//
//  ContentView.swift
//  Mise en Place
//
//  Created by Tanner King on 8/28/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController
    @State private var newIssueToggle = false
    @State private var refresh = false
    @State private var isEditing = false

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
//        RecipeGridView()
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(dataController.recipesForSelectedFilter()) { recipe in
                    NavigationLink {
                        RecipeView(recipe: recipe )
                    } label: {
                        VStack(spacing: 0) {
                            ZStack {
                                Rectangle()
                                    .aspectRatio(contentMode: .fill)
                                    .scaledToFit()
                                    .frame(maxWidth:.infinity)

                                if recipe.recipeStoredImage != nil {
                                    Image(uiImage: recipe.recipeStoredImage!)
                                        .resizable()
                                        .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
                                        .scaledToFit()
                                        .frame(maxWidth:.infinity)

                                } else {
                                        Text("No Image")
                                            .foregroundStyle(.white)
                                            .fontWeight(.bold)
                                }
                            }

                            VStack {
                                Text(recipe.recipeTitle)
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Text(recipe.recipeDifficultyString)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)

                            .background(.teal)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.teal)
                        )
                        .accessibilityAddTraits(.isButton)

        
                        .accessibilityElement()
                        .accessibilityValue(recipe.recipeTitle)
                        .accessibilityHint(recipe.recipeDifficultyString)
                    }
                    .contextMenu {
                        Button {
                            dataController.selectedRecipe = recipe
                            isEditing = true
                        } label: {
                            Label("Edit Recipe", systemImage: "square.and.pencil.circle")
                        }

                        Button(role: .destructive) {
                            dataController.delete(recipe)
                        } label: {
                            Label("Delete Recipe", systemImage: "trash.circle")
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }

        .navigationTitle("Recipes")

        .toolbar {
            Button() {
                dataController.newRecipe()
                refresh.toggle()
            } label: {
            Label("New Recipe",systemImage: "square.and.pencil")
            }
        }
        .searchable(text: $dataController.filterText)
    }

    func delete(_ offsets: IndexSet){
        let recipes = dataController.recipesForSelectedFilter()

        for offset in offsets {
            let item = recipes[offset]
            dataController.delete(item)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
