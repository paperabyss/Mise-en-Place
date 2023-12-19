//
//  DayView.swift
//  Mise en Place
//
//  Created by Tanner King on 12/15/23.
//

import SwiftUI

struct DayView: View {
    var day: String
    var body: some View {
        let meals = ["Breakfast", "Lunch", "Dinner"]
            VStack {
                // Date display in the top-left corner
                HStack {
                    Spacer()
                    Text(day)
                        .font(.headline)

                    // Line extending to the right
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(height: 2)
                        .background(Color.black)
                        .padding(.horizontal, 16)

                }
                    // Meal selector
                    VStack {
                        ForEach(meals,id: \.self) { meal in
                            NavigationLink(destination: Text(meal)) {
                                NavigationArea(text: meal)
                            }
                        }
                    }
                    .padding(.leading, 58)
                    .padding(.horizontal, 16)
            }
    }

    // Function to get the current date
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter.string(from: Date())
    }
}

// Custom view for the line
struct Line: View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color.black)
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
    }
}

//#Preview {
//    DayView()
//}
