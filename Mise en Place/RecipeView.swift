//
//  RecipeView.swift
//  Mise en Place
//
//  Created by Tanner King on 9/18/23.
//

import SwiftUI

struct RecipeView: View {
    @ObservedObject var recipe: Recipe
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: Recipe.example)
    }
}
