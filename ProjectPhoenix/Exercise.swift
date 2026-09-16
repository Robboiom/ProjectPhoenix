//
//  Exercise.swift
//  ProjectPhoenix
//
//  Created by JASON ROBERTS on 09/03/2026.
//

import Foundation
import SwiftData

@Model
class Exercise {
    var exerciseId: Int
    var exerciseName: String
    var category: String
    var exerciseDescription: String

    init(exerciseId: Int, exerciseName: String, category: String, exerciseDescription: String) {
        self.exerciseId = exerciseId
        self.exerciseName = exerciseName
        self.category = category
        self.exerciseDescription = exerciseDescription
    }
}
