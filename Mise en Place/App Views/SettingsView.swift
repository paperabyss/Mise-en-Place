//
//  SettingsView.swift
//  Mise en Place
//
//  Created by Tanner King on 2/26/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("App Appearance")) {
                    Picker("Theme:", selection: $dataController.theme) {
                        ForEach(dataController.themes, id: \.self) {
                            ColorPickerView(colorName: $0)
                        }
                    }
                }

                Section(header: Text("Recipe Layout")) {
                    Picker("Recipe Size", selection: $dataController.columnSize) {
                        Text("Compact").tag(100)
                        Text("Normal").tag(150)
                        Text("Large").tag(200)
                    }
                    Toggle("Show recipe difficulty", isOn: $dataController.showRecipeDifficulty)
                }
            }
            .navigationTitle("Settings")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    SettingsView()
}
