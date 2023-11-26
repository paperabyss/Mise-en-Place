//
//  ContentView.swift
//  Mise en Place
//
//  Created by Tanner King on 8/28/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        TabView {
            
            RecipeGridView()
                .tabItem {
                    Label("Recipes", systemImage: "book.pages")
                }

            MealPlannerView()
                .tabItem{
                    Label("Meal Planner", systemImage: "calendar")
                }
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
