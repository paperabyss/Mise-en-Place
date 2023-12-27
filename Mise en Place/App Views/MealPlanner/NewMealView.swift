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
                        Picker("Recipe", selection: $meal.recipe){
                            ForEach(dataController.recipesForSelectedFilter()) { recipe in
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
