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
                .onDelete(perform: deleteMeal)
            }
            .navigationTitle("MealPlanner")
            .toolbar {
                Button {
                    print("this is a button")
                } label: {
                    Label("Save and Close",systemImage: "folder.badge.plus")
                }
            }
        }
    }


    func deleteMeal(_ offsets: IndexSet) {
        withAnimation{
            let steps = dataController.mealsForTheWeek()
            for offset in offsets {
                let item = steps[offset]
                dataController.delete(item)
            }
        }
    }
}

#Preview {
    MealPlannerView()
}
