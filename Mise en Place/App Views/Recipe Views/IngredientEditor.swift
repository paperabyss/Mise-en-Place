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
                TextField("Ingredient", text: $ingredient.ingredientName, prompt: Text("Ingredient name"))
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                Rectangle()
                    .fill(.secondary)
                    .frame(height: 2)
                    .accessibilityHidden(true)


                HStack() {
                    Spacer()
                    TextField("Amount \(ingredient.massValue.formatted())", value: $ingredient.massValue, format: .number)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .keyboardType(.decimalPad)
                        .frame(alignment: .trailing)

                    Picker("Unit:", selection: $ingredient.ingredientMassUnit) {
                        ForEach(dataController.cookingUnits, id: \.self) {
                            Text("\($0)\(ingredient.massValue == 1 ? "": $0 != "" ? "s" : "")")
                        }
                    }
                    .labelsHidden()
                }
            }
            .accessibilityLabel(ingredient.ingredientName)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: 80)
            .onReceive(ingredient.objectWillChange) { _ in
            dataController.queueSave()
            
        }
    }
}


#Preview {
    IngredientEditor(ingredient: Ingredient.example)
}
