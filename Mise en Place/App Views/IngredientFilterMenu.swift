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
        ForEach(dataController.allIngredients()) { ingredient in
            Button {
                if dataController.filterIngredients.contains(ingredient){
                    dataController.filterIngredients.removeAll(where: { $0 == ingredient})

                } else {
                    dataController.filterIngredients.append(ingredient)
                }
            } label: {
                HStack{
                    Text(ingredient.ingredientName)
                    if dataController.filterIngredients.contains(ingredient) {
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
