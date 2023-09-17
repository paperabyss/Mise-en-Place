//
//  NoRecipeView.swift
//  Mise en Place
//
//  Created by Tanner King on 9/18/23.
//

import SwiftUI

struct NoRecipeView: View {
    @EnvironmentObject var dataController: DataController
    var body: some View {
        Text("No Recipe Selected")
            .font(.title)
            .foregroundStyle(.secondary)

        Button("New Recipe") {
            // make a new recipe
        }
    }
}

struct NoRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NoRecipeView()
    }
}
