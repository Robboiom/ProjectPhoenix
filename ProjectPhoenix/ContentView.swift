import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    @Query private var workouts: [WorkoutLog]
    @Query private var exercises: [Exercise]
    @Query private var topics: [GuidanceTopic]

    @State private var showingAddWorkout = false
    @State private var workoutNotes = ""
    @State private var workoutSets = ""
    @State private var workoutReps = ""
    @State private var workoutWeight = ""
    @State private var workoutDuration = ""
    @State private var selectedExerciseName = ""
    @State private var selectedCategory = "Chest"

    var body: some View {
        TabView {

            // 🔥 HOME TAB (your current app)
            NavigationStack {
                List {
                    Section("Workout Logs") {
                        ForEach(workouts) { workout in
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Exercise: \(workout.exerciseName)")
                                    .font(.headline)
                                Text("Sets: \(workout.sets), Reps: \(workout.reps)")
                                Text("Weight: \(workout.weight, specifier: "%.0f") kg, Duration: \(workout.duration, specifier: "%.0f") mins")
                                Text("Note: \(workout.notes)")
                            }
                        }
                        .onDelete(perform: deleteWorkouts)
                    }

                    Section("Exercise Library") {
                        ForEach(exercises) { exercise in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(exercise.exerciseName)
                                    .font(.headline)
                                Text("Category: \(exercise.category)")
                                Text(exercise.exerciseDescription)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }

                    Section("Tips & Guidance") {
                        ForEach(topics) { topic in
                            NavigationLink {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(topic.title)
                                        .font(.title2)
                                        .bold()
                                    Text(topic.content)
                                }
                                .padding()
                            } label: {
                                Text(topic.title)
                            }
                        }
                    }
                }
                .navigationTitle("Project Phoenix")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }

                    ToolbarItem {
                        Button {
                            if let firstExercise = exercises.first(where: { $0.category == selectedCategory }) {
                                selectedExerciseName = firstExercise.exerciseName
                            }
                            showingAddWorkout = true
                        } label: {
                            Label("Add Workout", systemImage: "plus")
                        }
                    }

                    ToolbarItem {
                        Button("Load Exercises") {
                            addTestExercises()
                        }
                    }

                    ToolbarItem {
                        Button("Load Tips") {
                            addTestTopics()
                        }
                    }
                }
                .sheet(isPresented: $showingAddWorkout) {
                    NavigationStack {
                        Form {
                            Picker("Category", selection: $selectedCategory) {
                                Text("Chest").tag("Chest")
                                Text("Back").tag("Back")
                                Text("Legs").tag("Legs")
                            }

                            Picker("Exercise", selection: $selectedExerciseName) {
                                ForEach(exercises.filter { $0.category == selectedCategory }, id: \.exerciseName) { exercise in
                                    Text(exercise.exerciseName).tag(exercise.exerciseName)
                                }
                            }
                            .onChange(of: selectedCategory) {
                                if let firstExercise = exercises.first(where: { $0.category == selectedCategory }) {
                                    selectedExerciseName = firstExercise.exerciseName
                                } else {
                                    selectedExerciseName = ""
                                }
                            }

                            TextField("Sets", text: $workoutSets)
                            TextField("Reps", text: $workoutReps)
                            TextField("Weight", text: $workoutWeight)
                            TextField("Duration (mins)", text: $workoutDuration)
                            TextField("Notes", text: $workoutNotes)
                        }
                        .navigationTitle("Add Workout")
                        .onAppear {
                            if let firstExercise = exercises.first(where: { $0.category == selectedCategory }) {
                                selectedExerciseName = firstExercise.exerciseName
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Cancel") {
                                    showingAddWorkout = false
                                }
                            }

                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Save") {
                                    addWorkout()
                                    showingAddWorkout = false
                                }
                                .disabled(exercises.isEmpty || selectedExerciseName.isEmpty)
                            }
                        }
                    }
                }
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }

            // 🍽️ DIET TAB
            DietLogView()
                .tabItem {
                    Label("Diet", systemImage: "fork.knife")
                }
        }
    }

    private func addWorkout() {
        withAnimation {
            let setsValue = Int(workoutSets) ?? 1
            let repsValue = Int(workoutReps) ?? 1
            let weightValue = Float(workoutWeight) ?? 0.0
            let durationValue = Float(workoutDuration) ?? 0.0

            let newWorkout = WorkoutLog(
                workoutLogId: Int.random(in: 1...100000),
                date: Date(),
                sets: setsValue,
                reps: repsValue,
                weight: weightValue,
                duration: durationValue,
                exerciseName: selectedExerciseName,
                notes: workoutNotes
            )

            modelContext.insert(newWorkout)

            workoutSets = ""
            workoutReps = ""
            workoutWeight = ""
            workoutDuration = ""
            workoutNotes = ""
        }
    }

    private func deleteWorkouts(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(workouts[index])
            }
        }
    }

    private func addTestExercises() {
        modelContext.insert(Exercise(exerciseId: 1, exerciseName: "Bench Press", category: "Chest", exerciseDescription: "Barbell chest press"))
        modelContext.insert(Exercise(exerciseId: 2, exerciseName: "Incline Dumbbell Press", category: "Chest", exerciseDescription: "Upper chest"))
        modelContext.insert(Exercise(exerciseId: 3, exerciseName: "Lat Pulldown", category: "Back", exerciseDescription: "Cable pull"))
        modelContext.insert(Exercise(exerciseId: 4, exerciseName: "Squat", category: "Legs", exerciseDescription: "Compound leg"))
    }

    private func addTestTopics() {
        modelContext.insert(GuidanceTopic(topicId: 1, title: "Progressive Overload", content: "Increase weight over time"))
        modelContext.insert(GuidanceTopic(topicId: 2, title: "Recovery", content: "Rest matters"))
        modelContext.insert(GuidanceTopic(topicId: 3, title: "Consistency", content: "Train regularly"))
    }
}
