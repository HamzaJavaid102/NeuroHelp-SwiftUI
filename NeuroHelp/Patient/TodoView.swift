//
//  TodoView.swift
//  NeuroHelp
//
//  Created by Hamza Javaid on 28/02/2024.
//

import SwiftUI

struct TodoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedWorkouts: Set<String> = []
    @State private var showAlert = false
    
    let allWorkouts = ["Workout 1", "Workout 2", "Workout 3", "Workout 4", "Workout 5", "Workout 6", "Workout 7", "Workout 8"]
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(allWorkouts, id: \.self) { workout in
                    HStack {
                        Text(workout)
                        Spacer()
                        Image(systemName: selectedWorkouts.contains(workout) ? "checkmark.square.fill" : "square")
                            .onTapGesture {
                                toggleSelection(for: workout)
                            }
                    }
                    .listRowBackground(Color.clear)
                    .background(.clear)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        toggleSelection(for: workout)
                    }
                }
                .background(Color.prussianBlue)
                .foregroundColor(.white)
                .listStyle(PlainListStyle())
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Congratulations!"), message: Text("You have completed all workouts."), dismissButton: .default(Text("Ok")))
                }
                .padding()
            }
            .background(Color.prussianBlue)
            .navigationTitle("Workout Selection")
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
    
    private func toggleSelection(for workout: String) {
        if selectedWorkouts.contains(workout) {
            selectedWorkouts.remove(workout)
        } else {
            selectedWorkouts.insert(workout)
        }
        
        if selectedWorkouts.count == allWorkouts.count {
            showAlert = true
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}
