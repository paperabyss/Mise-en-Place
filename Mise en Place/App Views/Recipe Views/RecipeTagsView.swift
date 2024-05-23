//
//  RecipeTagsView.swift
//  Mise en Place
//
//  Created by Tanner King on 5/22/24.
//

import SwiftUI

struct RecipeTagsView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var recipe: Recipe
    var body: some View {
        let columns = [
            GridItem(.adaptive(minimum: CGFloat(dataController.columnSize)))
        ]
        LazyVGrid(columns: columns) {
            ForEach(recipe.recipeTags){ tag in
                ZStack {
                    Rectangle()
                        .frame(width: 100, height: 50)
                        .foregroundStyle(Theme.outlines)
                        .scaledToFit()
                        .aspectRatio(CGSize(width: 2, height: 1), contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Theme.outlines)
                        )
                    Text(tag.tagName)
                        .font(.footnote)
                        .foregroundStyle(Theme.text)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    RecipeTagsView(recipe: Recipe.example)
}
