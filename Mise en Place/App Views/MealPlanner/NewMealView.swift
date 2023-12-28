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

    @State var date: Date = .now
    @State var recipe: Recipe

    var body: some View {


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

                        Picker("Meal Type", selection: $meal.mealType) {
                            Text("Breakfast").tag("Breakfast")
                            Text("Lunch").tag("Lunch")
                            Text("Dinner").tag("Dinner")
                        }
                        Text(meal.mealType)
                    }

                    Section{
                        Picker("Recipe", selection: $recipe){
                            ForEach(dataController.recipesForSelectedFilter(), id: \.self) { recipe in
                                Text(recipe.recipeTitle).tag(recipe)
                            }
                        }

                        Text("Selected recipe: \(recipe.title ?? "")")
                    }
                }
            }
        }
    }
}

//#Preview {
//    NewMealView(meal)
//}
