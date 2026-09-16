//
//  DietEntry.swift
//  ProjectPhoenix
//
//  Created by JASON ROBERTS on 13/03/2026.
//
import Foundation
import SwiftData

@Model
class DietEntry {
    var dietEntryId: Int
    var foodName: String
    var calories: Int
    var protein: Float
    var carbs: Float
    var fats: Float
    var date: Date

    init(dietEntryId: Int, foodName: String, calories: Int, protein: Float, carbs: Float, fats: Float, date: Date) {
        self.dietEntryId = dietEntryId
        self.foodName = foodName
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fats = fats
        self.date = date
    }
}
