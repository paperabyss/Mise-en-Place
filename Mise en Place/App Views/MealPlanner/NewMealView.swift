//
//  NewMealView.swift
//  Mise en Place
//
//  Created by Tanner King on 12/22/23.
//

import SwiftUI

struct NewMealView: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @ObservedObject var meal: Meal

    var body: some View {
        @State var date: Date = .now
        @State var recipes = dataController.recipesForSelectedFilter()
        NavigationView{
            VStack {
                List {
                    Section {
                        TextField(meal.mealName, text: $meal.mealName)
                    }

                    Section {
                        DatePicker (
                            "Meal Date",
                            selection: $date,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)

                        Picker("Meal Type", selection: $meal.type) {
                            Text("Breakfast").tag(dataController.mealTypes[0])
                            Text("Lunch").tag(dataController.mealTypes[1])
                            Text("Dinner").tag(dataController.mealTypes[2])
                        }
                    }

                    Section{
                        Picker("Recipe", selection: $meal.recipe){
                            ForEach(recipes) { recipe in
                                Text(recipe.recipeTitle)
                            }
                        }

                        Text("Selected recipe: \(meal.recipe?.title ?? "")")
                    }
                }
            }
        }
    }
}

//#Preview {
//    NewMealView(meal)
//}
