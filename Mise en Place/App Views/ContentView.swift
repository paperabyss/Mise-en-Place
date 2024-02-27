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
        var _: Bool = {
            loadDefaults()
            return true
        }()

        TabView(selection: $selection) {

            RecipeGridView()
                .tabItem {
                    Label("Recipes", systemImage: "book.pages")
                        .foregroundColor(Theme.outlines)
                }.tag(1)

            MealPlannerView()
                .tabItem{
                    Label("Meal Planner", systemImage: "calendar")
                        .foregroundColor(Theme.outlines)
                } .tag(2)

            SettingsView()
                .tabItem{
                    Label("Seetings", systemImage: "gear")
                        .foregroundStyle(Theme.outlines)
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

    func loadDefaults(){
        let userDefault = UserDefaults.standard
                Theme.loadTheme()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
