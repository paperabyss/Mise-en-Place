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
        Picker("Unit:", selection: $dataController.theme) {
            ForEach(dataController.themes, id: \.self) {
                Text($0)
            }
        }
    }
}

#Preview {
    SettingsView()
}
