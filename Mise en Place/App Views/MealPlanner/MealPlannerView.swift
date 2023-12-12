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
        var week = ["Mon", "Tues", "Wed", "Thur", "Friday", "Sat", "Sun"]
        var meal = ["Breakfast", "Lunch", "Dinner"]
        NavigationView {
            ScrollView{
                //            List{
                //                ForEach(dataController.mealsForTheWeek()) { meal in
                //                    NavigationLink {
                //                        MealRowView()
                //                    } label: {
                //                        HStack{
                //                            Text(meal.mealName)
                //
                //                            Text(meal.type ?? "Food")
                //
                //                            Text(" - ")
                //
                //                            Text(meal.mealTimeString)
                //                        }
                //                    }
                //                }
                //                .onDelete(perform: deleteMeal)
                //            }

                VStack {
                    ForEach(week, id: \.self) { day in
                        VStack {
                            Text ("Day \(day)")
                            Spacer()
                            ForEach(meal, id: \.self){ meal in
                                Text(meal)
                            }
                            Spacer()
                        }
                    }
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
