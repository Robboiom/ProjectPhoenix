//
//  Routine.swift
//  ProjectPhoenix
//
//  Created by JASON ROBERTS on 09/03/2026.
//
import Foundation
import SwiftData

@Model
class Routine {
    var routineId: Int
    var routineName: String
    var goal: String

    init(routineId: Int, routineName: String, goal: String) {
        self.routineId = routineId
        self.routineName = routineName
        self.goal = goal
    }
}
