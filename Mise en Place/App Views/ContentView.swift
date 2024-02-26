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
        var loadTheme: Bool = {
            Theme.loadTheme()
            return true
        }()

        TabView(selection: $selection) {

            RecipeGridView()
                .tabItem {
                    Label("Recipes", systemImage: "book.pages")
                        .foregroundColor(Theme.interactiveElements)
                }.tag(1)

            MealPlannerView()
                .tabItem{
                    Label("Meal Planner", systemImage: "calendar")
                        .foregroundColor(Theme.interactiveElements)
                } .tag(2)

            SettingsView()
                .tabItem{
                    Label("Seetings", systemImage: "gear")
                        .foregroundStyle(Theme.interactiveElements)
                } .tag(3)


        }
        .accentColor(Theme.interactiveElements)
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
