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
            Section {
                List{
                    ForEach(dataController.mealsForTheWeek()) { meal in
                        NavigationLink {
                            MealRowView()
                        } label: {
                            HStack{
                                Text(meal.mealName)

                                Text(meal.type ?? "Food")

                                Text(" - ")

                                Text(meal.mealTimeString)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Meal Planner")
    }
}

#Preview {
    MealPlannerView()
}
