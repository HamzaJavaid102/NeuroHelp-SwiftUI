//
//  PatientProgressView.swift
//  NeuroHelp
//
//  Created by Hamza Javaid on 27/02/2024.
//

import SwiftUI

struct PatientListProgressView: View {
    
    @State private var selectedPatient: PatientProgressModel?
    @State private var isShowingPatientProgress = false
    @Environment(\.presentationMode) var presentationMode
    
    var patients: [PatientProgressModel] = [
        PatientProgressModel(id: UUID(), name: "John Doe", progress: 0.5, completedSessions: 10),
        PatientProgressModel(id: UUID(), name: "Mills", progress: 0.8, completedSessions: 15),
        PatientProgressModel(id: UUID(), name: "John Doe", progress: 0.9, completedSessions: 18),
        PatientProgressModel(id: UUID(), name: "Mills", progress: 1.0, completedSessions: 20),
    ]
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(patients) { patient in
                    PatientListItemProgressView(patient: patient)
                        .onTapGesture {
                            selectedPatient = patient
                        }
                        .listRowBackground(Color.clear)
                }
                .background(Color.prussianBlue)
                .foregroundColor(.white)
                .listStyle(PlainListStyle())
            }
            .background(Color.prussianBlue)
            .overlay(
                PatientProgressPopup(selectedPatient: $selectedPatient, isPresented: $isShowingPatientProgress)
            )
            .navigationTitle("Select Patient to check progress")
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

struct PatientProgressPopup: View {
    @Binding var selectedPatient: PatientProgressModel?
    @Binding var isPresented: Bool
    
    var body: some View {
        if let patient = selectedPatient {
            GeometryReader { geometry in
                ZStack {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Spacer()
                        PatientProgressView(patient: patient, isPresented: $isPresented)
                        Button("Dismiss") {
                            selectedPatient = nil
                            isPresented = false
                        }
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.prussianBlue)
                        .cornerRadius(8)
                        .padding(.top, 20)
                        Spacer()
                    }
                    .frame(width: min(geometry.size.width - 40, 300),
                           height: min(geometry.size.height - 200, 400))
                    .background(Color.prussianBlue)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .animation(.easeInOut)
                    .onTapGesture {
                        selectedPatient = nil
                        isPresented = false
                    }
                }
            }
            .zIndex(1)
        }
    }
}

struct PatientListItemProgressView: View {
    var patient: PatientProgressModel
    
    var body: some View {
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
                Text("Completed Sessions: \(patient.completedSessions)")
                    .font(.subheadline)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.lightSky)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
    }
}

struct PatientProgressView: View {
    var patient: PatientProgressModel
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            CircularProgressBar(progress: patient.progress)
                .frame(width: 150, height: 150)
            
            Text("Patient: \(patient.name)")
                .font(.headline)
                .foregroundColor(.white)
            
            Text("Completed Sessions: \(patient.completedSessions)")
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.prussianBlue)
        .cornerRadius(20)
    }
}

struct CircularProgressBar: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .foregroundColor(Color.blue)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
        }
    }
}

struct PatientProgressModel: Identifiable {
    var id: UUID
    var name: String
    var progress: Double
    var completedSessions: Int
}

struct PatientProgressView_Previews: PreviewProvider {
    static var previews: some View {
        PatientListProgressView()
    }
}
