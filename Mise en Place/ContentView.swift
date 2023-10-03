//
//  ContentView.swift
//  Mise en Place
//
//  Created by Tanner King on 8/28/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController
    @State private var viewToggle = false

    var body: some View {
        Group {
            if viewToggle {
                    RecipeListView()
            } else {
                    RecipeGridView()
            }
        }
        .navigationTitle("Recipes")
        .toolbar {
            Button("Switch Layout") {
                viewToggle.toggle()
            }
        }
        .searchable(text: $dataController.filterText, prompt: "Search")
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
