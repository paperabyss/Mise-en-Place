//
//  FilterButtonMenu.swift
//  Mise en Place
//
//  Created by Tanner King on 5/20/24.
//

import SwiftUI

struct FilterButtonMenu: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        ForEach(dataController.allTags().sorted()) { tag in
            Button {
                if dataController.filterTags.contains(tag){
                    dataController.filterTags.removeAll(where: { $0 == tag})
                } else {
                    dataController.filterTags.append(tag)
                }
            } label: {
                HStack{
                    Text(tag.tagName)
                    if dataController.filterTags.contains(tag) {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
    }
}

#Preview {
    FilterButtonMenu()
}
