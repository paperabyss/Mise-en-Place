//
//  ColorPickerView.swift
//  Mise en Place
//
//  Created by Tanner King on 5/7/24.
//

import SwiftUI

struct ColorPickerView: View {
    let colorName: String
    var body: some View {
        HStack{
            Text(colorName)
            if #available(iOS 17.0, *) {
                Circle()
                    .stroke(.black, lineWidth: 2)
                    .fill(Theme.circleOne(name: colorName))
                    .frame(maxHeight: 10)
            } else {
                Circle()
                    .fill(Theme.circleOne(name: colorName))
                    .frame(maxHeight: 5)
            }
            if #available(iOS 17.0, *) {
                Circle()
                    .stroke(.black, lineWidth: 2)
                    .fill(Theme.circleTwo(name: colorName))
                    .frame(maxHeight: 10)
            } else {
                Circle()
                    .fill(Theme.circleOne(name: colorName))
                    .frame(maxHeight: 10)
            }

        }
    }
}

#Preview {
    ColorPickerView(colorName: "Lilac")
}
