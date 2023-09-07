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
        } else {
            let request = Recipe.fetchRequest()
            request.predicate = NSPredicate(format: "lastMade > %@", filter.lastMade as NSDate)
            allRecipes = (try? dataController.container.viewContext.fetch(request)) ?? []
        }
        return allRecipes.sorted()
    }

    var body: some View {
        List {
            ForEach(recipes) { recipe in
                Text(recipe.recipeTitle)
            }
        }
        Text("nsjfnsjfn")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
