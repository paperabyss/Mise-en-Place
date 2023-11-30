//
//  MealPlannerView.swift
//  Mise en Place
//
//  Created by Tanner King on 11/27/23.
//

import SwiftUI

struct MealPlannerView: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        NavigationView {
            ForEach(dataController.mealsForTheWeek()) { meal in
                HStack {
                    Text(meal.mealName)
                    Text(meal.type ?? "Food")
                }
            }
        }
        .navigationTitle("Meal Planner")
    }
}

#Preview {
    MealPlannerView()
}
