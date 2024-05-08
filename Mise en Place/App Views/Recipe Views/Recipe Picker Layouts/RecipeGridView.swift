//
//  RecipeGridView.swift
//  Mise en Place
//
//  Created by Tanner King on 9/18/23.
//

import SwiftUI

struct RecipeGridView: View {
    @EnvironmentObject var dataController: DataController


    @State private var newIssueToggle = false
    @State private var refresh = false
    @State private var editEnabled = false

    var body: some View {
        let columns = [
            GridItem(.adaptive(minimum: CGFloat(dataController.columnSize)))
        ]

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
                                        .scaledToFill()
                                        .frame(maxWidth:.infinity)
                                        .opacity(0.3)

                                    if recipe.recipeStoredImage != nil {
                                        Image(uiImage: recipe.recipeStoredImage!)
                                            .resizable()
                                        
                                            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
                                            .scaledToFill()
                                            .frame(minWidth: CGFloat(dataController.columnSize), minHeight: CGFloat(dataController.columnSize))


                                    } else {
                                        Text("No Image")
                                            .foregroundStyle(Theme.text)
                                            .fontWeight(.bold)
                                    }
                                }
                                .accessibilityHidden(true)

                                VStack {
                                    Text(recipe.recipeTitle)
                                        .font(.headline)
                                        .lineLimit(2)
                                        .minimumScaleFactor(0.75)
                                        .foregroundColor(Theme.text)
                                        .padding(.horizontal)


                                    if dataController.showRecipeDifficulty{
                                        Text(recipe.recipeDifficultyString)
                                            .font(.caption)
                                            .foregroundColor(Theme.text.opacity(0.5))
                                    }

                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .overlay(
                                    Rectangle()
                                        .stroke(Theme.outlines)
                                )

                                .background(Theme.interactiveElements)
                            }

                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Theme.outlines)
                            )
                            .accessibilityElement()
                            .accessibilityAddTraits(.isButton)
                            .accessibilityLabel(recipe.recipeTitle)
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
                        .foregroundColor(Theme.interactiveElements)
                }
                
                Button() {
                    dataController.newRecipe()
                    editEnabled.toggle()
                    refresh.toggle()
                } label: {
                    Label("New Recipe",systemImage: "square.and.pencil")
                }

                Button() {
                    dataController.changeSize()
                } label : {
                    Label("Change Grid Size", systemImage: "circle.grid.3x3.circle")
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
