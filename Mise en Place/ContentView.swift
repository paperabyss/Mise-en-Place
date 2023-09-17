//
//  ContentView.swift
//  Mise en Place
//
//  Created by Tanner King on 8/28/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController

    var recipes: [Recipe] {
        let filter = dataController.selectedFilter ?? .all
        var allRecipes: [Recipe]

        if let tag = filter.tag {
            allRecipes = tag.recipes?.allObjects as? [Recipe] ?? []
        }
        else {
            let request = Recipe.fetchRequest()
            request.predicate = NSPredicate(format: "lastMade > %@", filter.minLastMade as NSDate)

            allRecipes = (try? dataController.container.viewContext.fetch(request)) ?? []
        }
        return allRecipes.sorted()
    }

    var body: some View {
        RecipeListView(recipes: recipes)
//        List {
//            ForEach(recipes) { recipe in
//                Text(recipe.recipeTitle)
//            }
//            .onDelete(perform: delete)
//        }
        .navigationTitle("Recipes")
    }

    func delete(_ offsets: IndexSet){
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
