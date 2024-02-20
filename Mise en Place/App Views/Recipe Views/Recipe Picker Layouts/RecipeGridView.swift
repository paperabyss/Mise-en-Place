//
//  RecipeGridView.swift
//  Mise en Place
//
//  Created by Tanner King on 9/18/23.
//

import SwiftUI

struct RecipeGridView: View {
    @EnvironmentObject var dataController: DataController

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    @State private var newIssueToggle = false
    @State private var refresh = false
    @State private var editEnabled = false

    var body: some View {
        NavigationView{
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
                                            .scaledToFill()
                                            .frame(
                                                maxWidth:150,
                                                maxHeight: 150
                                                    )


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
                                editEnabled = true
                            } label: {
                                Label("Edit Recipe", systemImage: "square.and.pencil")
                            }

                            Button(role: .destructive) {
                                dataController.delete(recipe)
                            } label: {
                                Label("Delete Recipe", systemImage: "trash")
                            }
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Recipes")
            .sheet(isPresented: $editEnabled){
                New_EditRecipeView(recipe: dataController.selectedRecipe!)
            }
            .toolbar {
                Button {
                    dataController.deleteAll()
                    dataController.createSampleData()
                } label: {
                    Label("ADD SAMPLE DATA", systemImage: "flame")
                }
                
                Button() {
                    dataController.newRecipe()
                    editEnabled.toggle()
                    refresh.toggle()
                } label: {
                    Label("New Recipe",systemImage: "square.and.pencil")
                }
            }
            .searchable(text: $dataController.filterText)
        }
    }
}

struct RecipeGridView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeGridView()
    }
}
