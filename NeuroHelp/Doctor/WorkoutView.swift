//
//  WorkoutView.swift
//  NeuroHelp
//
//  Created by Hamza Javaid on 28/02/2024.
//

import SwiftUI

struct PatientWorkoutModel: Identifiable, Equatable {
    var id: UUID
    var name: String
    var lastVisted: String
    var workouts: [String]
    
    static func == (lhs: PatientWorkoutModel, rhs: PatientWorkoutModel) -> Bool {
        return lhs.id == rhs.id
    }
}

class PatientsViewModel: ObservableObject {
    @Published var patients: [PatientWorkoutModel] = [
        PatientWorkoutModel(id: UUID(), name: "John Doe", lastVisted: "2022-02-28", workouts: ["Workout 1", "Workout 2", "Workout 3"]),
        PatientWorkoutModel(id: UUID(), name: "Jane Doe", lastVisted: "2022-02-22", workouts: []),
        PatientWorkoutModel(id: UUID(), name: "John Doe", lastVisted: "2022-03-10", workouts: []),
        PatientWorkoutModel(id: UUID(), name: "Jane Doe", lastVisted: "2022-01-11", workouts: []),
    ]
}

struct WorkoutView: View {
    @StateObject private var viewModel = PatientsViewModel()
    @State private var selectedPatient: PatientWorkoutModel?
    @State private var isShowingPatientProgress = false
    
    @Environment(\.presentationMode) var presentationMode
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.patients, id: \.id) { patient in
                    PatientWorkoutRow(
                        patient: $viewModel.patients[viewModel.patients.firstIndex(where: { $0.id == patient.id }) ?? 0],
                        updateWorkouts: {
                            print("Updated Patient: \(patient)")
                        }
                    )
                    .onTapGesture {
                        selectedPatient = patient
                        isShowingPatientProgress = true
                    }
                    .listRowBackground(Color.clear)
                }
                .background(Color.prussianBlue)
                .foregroundColor(.white)
                .listStyle(PlainListStyle())
                .onChange(of: viewModel.patients) { updatedPatients in
                    print("Patients Updated")
                }
            }
            .background(Color.prussianBlue)
            .overlay(
                WorkoutPopup(selectedPatient: $selectedPatient, isPresented: $isShowingPatientProgress)
            )
            .onAppear {
                isShowingPatientProgress = false
            }
            .navigationTitle("Workouts")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.white)
                }
            )
        }
    }
}
struct PatientWorkoutRow: View {
    @Binding var patient: PatientWorkoutModel
    var updateWorkouts: () -> Void
    
    var body: some View {
        VStack() {
            HStack(spacing: 12) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
                    .foregroundColor(.white)
                
                VStack(alignment: .leading) {
                    Text("Patient: \(patient.name)")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Last Visit: \(patient.lastVisted)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            
            ForEach(patient.workouts, id: \.self) { workout in
                WorkoutItemView(workout: workout)
            }
            
            Spacer()
        }
        .frame(minHeight: 60)
        .frame(width: (UIScreen.main.bounds.width) - 60)
        .padding()
        .background(.lightSky)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
        .onChange(of: patient.workouts) { _ in
            updateWorkouts()
        }
    }
}

struct WorkoutItemView: View {
    var workout: String
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.square.fill")
            Text(workout)
            
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.vertical, 5)
    }
}

struct WorkoutPopup: View {
    @Binding var selectedPatient: PatientWorkoutModel?
    @Binding var isPresented: Bool
    
    let allWorkouts = ["Workout 1", "Workout 2", "Workout 3", "Workout 4", "Workout 5", "Workout 6", "Workout 7", "Workout 8"]
    
    var body: some View {
        if let patient = selectedPatient {
            GeometryReader { geometry in
                ZStack {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Spacer()
                        Text("Select Workouts")
                            .font(.headline)
                            .padding(.bottom, 10)
                        
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(allWorkouts, id: \.self) { workout in
                                    HStack {
                                        WorkoutCheckboxView(workout: workout, isChecked: selectedPatient?.workouts.contains(workout) ?? false) {
                                            if var selectedPatient = selectedPatient {
                                                if let index = selectedPatient.workouts.firstIndex(of: workout) {
                                                    selectedPatient.workouts.remove(at: index)
                                                } else {
                                                    selectedPatient.workouts.insert(workout, at: 0)
                                                }
                                                self.selectedPatient = selectedPatient
                                            }
                                        }
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .padding()
                        
                        Button("Dismiss") {
                            selectedPatient = nil
                            isPresented = false
                        }
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.prussianBlue)
                        .cornerRadius(8)
                        Spacer()
                    }
                    .padding()
                    .frame(width: min(geometry.size.width - 40, 300), height: min(geometry.size.height - 200, 400))
                    .foregroundColor(.white)
                    .background(Color.prussianBlue)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .onTapGesture {
                        // Close the popup when tapped outside
                        selectedPatient = nil
                        isPresented = false
                    }
                    
                    Spacer()
                }
            }
            .zIndex(1)}
    }
}

struct WorkoutCheckboxView: View {
    var workout: String
    var isChecked: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                Text(workout)
            }
        }
    }
}

#Preview {
    WorkoutView()
}
