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

    var body: some View {

        let recipes: [Recipe] = dataController.recipesForSelectedFilter()

        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(recipes) { recipe in
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
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct RecipeGridView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeGridView()
    }
}
