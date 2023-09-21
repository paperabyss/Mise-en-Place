//
//  DetailView.swift
//  Mise en Place
//
//  Created by Tanner King on 8/29/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var dataController: DataController
    var body: some View {
        VStack {
            if let recipe = dataController.selectedRecipe {
                RecipeView(recipe: recipe)
            } else {
                NoRecipeView()
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
