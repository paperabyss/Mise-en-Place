//
//  NoRecipeView.swift
//  Mise en Place
//
//  Created by Tanner King on 9/18/23.
//

import SwiftUI

struct NoRecipeView: View {
    @EnvironmentObject var dataController: DataController
    @State private var showingEditing = false

    var body: some View {
        Text("No Recipe Selected")
            .font(.title)
            .foregroundStyle(.secondary)

        Button("New Recipe") {
            dataController.newRecipe()
            showingEditing.toggle()
        }
    }
}

struct NoRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NoRecipeView()
    }
}
