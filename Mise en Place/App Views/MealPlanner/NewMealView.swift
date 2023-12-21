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

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//#Preview {
//    NewMealView(meal)
//}
