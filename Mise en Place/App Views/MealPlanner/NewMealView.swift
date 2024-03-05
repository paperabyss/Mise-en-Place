//
//  NewMealView.swift
//  Mise en Place
//
//  Created by Tanner King on 12/22/23.
//

import SwiftUI

struct NewMealView: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.dismiss) var dismiss
    @ObservedObject var meal: Meal

    @State var date: Date
    @State  var day: String
    @State var recipe: Recipe



    var body: some View {
        let recipes = dataController.recipesForSelectedFilter()


        NavigationView{
            VStack {
                List {

                    Section {
                        DatePicker (
                            "Meal Date",
                            selection: $date,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .accentColor(Theme.interactiveElements)

                        Picker("Meal Type", selection: $meal.mealType) {
                            Text("Breakfast").tag("Breakfast")
                            Text("Lunch").tag("Lunch")
                            Text("Dinner").tag("Dinner")
                        }
                        Text(meal.mealType)
                    }

                    Section{
                        Picker("Recipe", selection: $recipe){
                            ForEach(recipes, id: \.self) { recipe in
                                Text(recipe.recipeTitle).tag(recipe)
                            }
                        }

                        Text("Selected recipe: \(recipe.title ?? "")")
                    }
                }
            }
            .toolbar {
                Button() {
                    meal.day = dataController.getDateFormatted(date: date)
                    meal.recipe = recipe
                    dataController.save()
                    dismiss()
                } label: {
                Label("Save and Close",systemImage: "folder.badge.plus")
                }
                .foregroundStyle(Theme.interactiveElements)
                .accentColor(Theme.interactiveElements)
            }
        }
    }
}

//#Preview {
//    NewMealView(meal)
//}
