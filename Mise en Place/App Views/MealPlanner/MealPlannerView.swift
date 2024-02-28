//
//  MealPlannerView.swift
//  Mise en Place
//
//  Created by Tanner King on 11/27/23.
//

import SwiftUI

struct MealPlannerView: View {
    @EnvironmentObject var dataController: DataController
    @State private var currentDate = Date()
    @State private var showingMealPlanner = false



    var body: some View {
        @State var meal: Meal?
        @State var weeksMeals = dataController.mealsForTheWeek(date: currentDate)
        @State var dates = dataController.getCurrentWeekDates(date: currentDate)
        @State var days = dataController.getCurrentWeekDatesFormatted(date: currentDate)


        if dataController.recipesForSelectedFilter().count == 0 {
                Text("Please make a recipe first.")
        } else {
            NavigationView {
                ScrollView{
                    HStack {
                        //This button changes the meal list to the previous week.
                        Button {
                            currentDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate) ?? Date()
                            print(currentDate.formatted())
                            if weeksMeals.isEmpty {print("Empty meal list")}
                        } label: {
                            Image(systemName: "arrowshape.left.fill")
                                .foregroundColor(Theme.interactiveElements)
                        }

                        Text("\(days[0]) - \(days[6])")

                        //This button changes the meal list to the next week.
                        Button {
                            currentDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate) ?? Date()
                            print(currentDate.formatted())
                            if weeksMeals.isEmpty {print("Empty meal list")}
                        } label: {
                            Image(systemName: "arrowshape.right.fill")
                                .foregroundColor(Theme.interactiveElements)
                        }
                    }

                    //This area shows the days of the week and the meals for them.
                    VStack {
                        ForEach(Array(days.enumerated()), id: \.1) { (index, day) in
                            DayView(day: day, date: dates[index] )
                        }
                    }
                }
                .navigationTitle("MealPlanner")
            }
        }
    }


    func deleteMeal(_ offsets: IndexSet) {
        withAnimation{
            let steps = dataController.mealsForTheWeek(date: currentDate)
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
