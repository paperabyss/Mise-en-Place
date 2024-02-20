//
//  IngredientEditor.swift
//  Mise en Place
//
//  Created by Tanner King on 10/17/23.
//

import SwiftUI

struct IngredientEditor: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var ingredient: Ingredient
    var body: some View {
        VStack {
            VStack {
                TextField("Ingredient", text: $ingredient.ingredientName, prompt: Text("Enter the name of your ingredient here"))
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal)

                Stepper("Amount \(ingredient.massValue.formatted())", value: $ingredient.massValue, in: 1...100)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
                    .keyboardType(.decimalPad)

                HStack() {
                    Picker("Unit", selection: $ingredient.ingredientMassUnit) {
                        ForEach(dataController.cookingUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .frame(alignment: .trailing)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.teal)
        }
        .onReceive(ingredient.objectWillChange) { _ in
            dataController.queueSave()
        }
        .onSubmit(dataController.save)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.teal)
        )
    }
}


#Preview {
    IngredientEditor(ingredient: Ingredient.example)
}
