//
//  StepEditor.swift
//  Mise en Place
//
//  Created by Tanner King on 10/18/23.
//

import SwiftUI

struct StepEditor: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var step: Step

    var body: some View {
        VStack {
            VStack {
                TextField("Instruction", text: $step.stepInstruction, prompt: Text("Enter the instruction here."))
                    .font(.headline)
                    .foregroundColor(.white)
                    .onReceive(step.objectWillChange) { _ in
                        dataController.queueSave()
                    }

            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.teal)
            .onSubmit(dataController.save)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.teal)
        )
    }
}

#Preview {
    StepEditor(step: Step.example)
}
