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

        @State var showingMealPlanner = false
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
                    }

                    Text("\(days[0]) - \(days[6])")

                    //This button changes the meal list to the next week.
                    Button {
                        currentDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate) ?? Date()
                        print(currentDate.formatted())
                        if weeksMeals.isEmpty {print("Empty meal list")}
                    } label: {
                        Image(systemName: "arrowshape.right.fill")
                    }
                }

                //This area shows the days of the week and the meals for them.
                VStack {
                    ForEach(days, id: \.self) { day in
                        DayView(day: day)
                    }
                }
                .navigationTitle("MealPlanner")
                .sheet(isPresented: $showingMealPlanner){
                    NewMealView(meal: dataController.selectedMeal!)
                }
                .toolbar {
                    Button {
                        dataController.newMeal()
                        showingMealPlanner.toggle()


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
