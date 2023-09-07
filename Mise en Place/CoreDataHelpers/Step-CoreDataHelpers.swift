//
//  Step-CoreDataHelpers.swift
//  Mise en Place
//
//  Created by Tanner King on 9/5/23.
//

import Foundation

extension Step {

    var stepInstruction: String {
        get { instruction ?? ""}
        set { instruction = newValue}
    }

    var stepID: UUID {
        id ?? UUID()
    }

    static var example: Step {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext

        let step = Step(context: viewContext)
        step.number = 1
        step.instruction = "Example instruction."
        return step
    }
}

extension Step: Comparable {
    public static func <(lhs: Step, rhs: Step) -> Bool{
        let left = lhs.number
        let right = rhs.number

        if left == right {
            return lhs.stepID.uuidString < rhs.stepID.uuidString
        } else {
            return left < right
        }
    }
}
