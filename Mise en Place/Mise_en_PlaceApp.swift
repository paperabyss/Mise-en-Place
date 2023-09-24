//
//  Mise_en_PlaceApp.swift
//  Mise en Place
//
//  Created by Tanner King on 8/28/23.
//

import SwiftUI

@main
struct Mise_en_PlaceApp: App {
    @StateObject var dataController = DataController()
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            NavigationSplitView{
                SidebarView()
            } content: {
                ContentView()
            } detail: {
                DetailView()
            }
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .onChange(of: scenePhase) { phase in
                    if phase != .active {
                        dataController.save()
                    }
                }
        }
    }
}
