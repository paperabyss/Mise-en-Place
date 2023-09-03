//
//  SidebarView.swift
//  Mise en Place
//
//  Created by Tanner King on 8/29/23.
//

import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var dataController: DataController
    let smartFilters: [Filter] = [.all, .recent]

    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var tags: FetchedResults<Tag>

    var tagFilters: [Filter] {
        tags.map { tag in
            Filter(id: tag.id ?? UUID(), name: tag.name ?? "No Name", icon: "tag", tag: tag)
        }
    }

    var body: some View {
        List(selection: $dataController.selectedFilter) {
            Section("Smart Filter"){
                ForEach(smartFilters) { filter in
                    NavigationLink(value: filter) {
                        Label(filter.name, systemImage: filter.icon)
                    }
                }
            }

            Section("Tags") {
                ForEach(tagFilters) { filter in
                    NavigationLink(value: filter){
                        Label(filter.name, systemImage: filter.icon)
                    }
                }
            }
        }
        .toolbar {
            Button {
                dataController.deleteAll()
                dataController.createSampleData()
            } label: {
                Label("ADD SAMPLE DATA", systemImage: "flame")
            }
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
            .environmentObject(DataController.preview)
    }
}
