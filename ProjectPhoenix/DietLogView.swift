//
//  DietLogView.swift
//  ProjectPhoenix
//
//  Created by JASON ROBERTS on 13/03/2026.
//
import SwiftUI
import SwiftData

struct DietLogView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var dietEntries: [DietEntry]

    @State private var showingAddDietEntry = false
    @State private var foodName = ""
    @State private var protein = ""
    @State private var carbs = ""
    @State private var fats = ""

    var calculatedCalories: Int {
        let proteinValue = Float(protein) ?? 0.0
        let carbsValue = Float(carbs) ?? 0.0
        let fatsValue = Float(fats) ?? 0.0

        return Int((proteinValue * 4) + (carbsValue * 4) + (fatsValue * 9))
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(dietEntries) { entry in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(entry.foodName)
                            .font(.headline)
                        Text("Calories: \(entry.calories)")
                        Text("Protein: \(entry.protein, specifier: "%.0f")g, Carbs: \(entry.carbs, specifier: "%.0f")g, Fats: \(entry.fats, specifier: "%.0f")g")
                    }
                }
                .onDelete(perform: deleteDietEntries)
            }
            .navigationTitle("Diet Log")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }

                ToolbarItem {
                    Button {
                        showingAddDietEntry = true
                    } label: {
                        Label("Add Food", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddDietEntry) {
                NavigationStack {
                    Form {
                        TextField("Food Name", text: $foodName)
                        TextField("Protein (g)", text: $protein)
                        TextField("Carbs (g)", text: $carbs)
                        TextField("Fats (g)", text: $fats)

                        HStack {
                            Text("Calories")
                            Spacer()
                            Text("\(calculatedCalories)")
                                .foregroundStyle(.gray)
                        }
                    }
                    .navigationTitle("Add Food")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                showingAddDietEntry = false
                            }
                        }

                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Save") {
                                addDietEntry()
                                showingAddDietEntry = false
                            }
                        }
                    }
                }
            }
        }
    }

    private func addDietEntry() {
        withAnimation {
            let proteinValue = Float(protein) ?? 0.0
            let carbsValue = Float(carbs) ?? 0.0
            let fatsValue = Float(fats) ?? 0.0
            let caloriesValue = Int((proteinValue * 4) + (carbsValue * 4) + (fatsValue * 9))

            let newEntry = DietEntry(
                dietEntryId: Int.random(in: 1...100000),
                foodName: foodName,
                calories: caloriesValue,
                protein: proteinValue,
                carbs: carbsValue,
                fats: fatsValue,
                date: Date()
            )

            modelContext.insert(newEntry)

            foodName = ""
            protein = ""
            carbs = ""
            fats = ""
        }
    }

    private func deleteDietEntries(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(dietEntries[index])
            }
        }
    }
}
