//
//  IngredientFilterMenu.swift
//  Mise en Place
//
//  Created by Tanner King on 5/23/24.
//

import SwiftUI

struct IngredientFilterMenu: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        ForEach(dataController.uniqueIngredients()) { ingredient in
            Button {
                if dataController.filterIngredients.contains(ingredient.ingredientName){
                    dataController.filterIngredients.removeAll(where: { $0 == ingredient.ingredientName})

                } else {
                    dataController.filterIngredients.append(ingredient.ingredientName)
                }
            } label: {
                HStack{
                    Text(ingredient.ingredientName)
                    if dataController.filterIngredients.contains(ingredient.ingredientName) {
                        Image(systemName: "checkmark")
                    }
                }
            }

        }
    }
}

#Preview {
    IngredientFilterMenu()
}
