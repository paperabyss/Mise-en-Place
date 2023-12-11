//
//  ContentView.swift
//  Mise en Place
//
//  Created by Tanner King on 8/28/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController
    @State var selection = 1

    var body: some View {
        TabView(selection: $selection) {

            RecipeGridView()
                .tabItem {
                    Label("Recipes", systemImage: "book.pages")
                }.tag(1)

            MealPlannerView()
                .tabItem{
                    Label("Meal Planner", systemImage: "calendar")
                } .tag(2)


        }
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
