//
//  Workout.swift
//  ProjectPhoenix
//
//  Created by JASON ROBERTS on 08/03/2026.
//
import Foundation
import SwiftData

@Model
class WorkoutLog {
    var workoutLogId: Int
    var date: Date
    var sets: Int
    var reps: Int
    var weight: Float
    var duration: Float
    var exerciseName: String
    var notes: String

    init(workoutLogId: Int, date: Date, sets: Int, reps: Int, weight: Float, duration: Float, exerciseName: String, notes: String) {
        self.workoutLogId = workoutLogId
        self.date = date
        self.sets = sets
        self.reps = reps
        self.weight = weight
        self.duration = duration
        self.exerciseName = exerciseName
        self.notes = notes
    }
}
