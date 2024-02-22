//
//  DayView.swift
//  Mise en Place
//
//  Created by Tanner King on 12/15/23.
//

import SwiftUI

struct DayView: View {
    @EnvironmentObject var dataController: DataController
    @State private var showingMealPlanner = false
    var day: String
    var date: Date 


    var body: some View {
        let meals = dataController.mealsForTheDay(day: day)
        let mealTypes = ["Breakfast", "Lunch", "Dinner"]
            VStack {
                // Date display in the top-left corner
                HStack {
                    Spacer()
                    Text(day)
                        .font(.headline)

                    // Line extending to the right
                    Rectangle()
                        .foregroundColor(.secondary)
                        .frame(height: 2)
                        .background(.primary)
                        .padding(.horizontal, 16)

                }
                    // Meal selector
                    VStack {

                        //Currently Planned Meals

                        ForEach(mealTypes, id: \.self) { type in
                            ForEach(meals) { meal in
                                if meal.mealType == type {
                                    NavigationLink(destination: RecipeView(recipe: meal.recipe ?? Recipe.example)) {
                                        NavigationArea(text: "\(meal.mealType) - \(meal.recipe?.recipeTitle ?? "")")
                                    }                               
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            dataController.delete(meal)
                                        } label: {
                                            Label("Delete Meal", systemImage: "trash")
                                        }
                                    }
                                }
                            }
                        }


                        //Button to add a meal
                        Button {

                            dataController.newMeal(day: day)

                            showingMealPlanner.toggle()
                        } label: {
                            NavigationArea(text: "Plan a meal")
                        }

                    }
                    .padding(.leading, 58)
                    .padding(.horizontal, 16)
            }
            .sheet(isPresented: $showingMealPlanner) {
                NewMealView(meal: dataController.selectedMeal!,date: date, day: day, recipe: dataController.recipesForSelectedFilter()[0] )
            }
    }
}



// Custom view for the navigation areas
struct NavigationArea: View {
    var text: String

    var body: some View {
        Text(text)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

//#Preview {
//    DayView()
//}
