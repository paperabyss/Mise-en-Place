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


    var body: some View {
        @State var weeksMeals = dataController.mealsForTheWeek(date: currentDate)
        @State var days = dataController.getCurrentWeekDatesFormatted(date: currentDate)
        let meals = ["Breakfast", "Lunch", "Dinner"]
        NavigationView {
            ScrollView{

                HStack {
                    Button {
                        currentDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate) ?? Date()
                        print(currentDate.formatted())
                        if weeksMeals.isEmpty {print("Empty meal list")}
                    } label: {
                        Image(systemName: "arrowshape.left.fill")
                    }

                    Text("\(days[0]) - \(days[6])")

                    Button {
                        currentDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate) ?? Date()
                        print(currentDate.formatted())
                        if weeksMeals.isEmpty {print("Empty meal list")}
                    } label: {
                        Image(systemName: "arrowshape.right.fill")
                    }
                }

                VStack {
                    ForEach(days, id: \.self) { day in
                        DayView(day: day)
                    }

                    ForEach(weeksMeals) { weeksMeal in
                        Text(weeksMeal.day ?? "No day")
                        Text(weeksMeal.mealType)
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
