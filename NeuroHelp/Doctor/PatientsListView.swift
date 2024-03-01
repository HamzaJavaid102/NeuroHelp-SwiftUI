//
//  PatientListView.swift
//  NeuroHelp
//
//  Created by Hamza Javaid on 27/02/2024.
//

import SwiftUI

//MARK: - ListView
struct PatientsListView: View {
    
    var isFromPatient: Bool
    var patients: [PatientModel] = [
        PatientModel(id: UUID(), patientName: "John Doe", lastVisit: "2022-03-01"),
        PatientModel(id: UUID(), patientName: "Jane Doe", lastVisit: "2022-02-15"),
        PatientModel(id: UUID(), patientName: "Alice", lastVisit: "2022-01-20"),
    ]
    
    @Environment(\.presentationMode) var presentationMode
    
    init(isFromPatient: Bool) {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        self.isFromPatient = isFromPatient
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(patients) { patient in
                        NavigationLink(destination: isFromPatient ? DoctorProfileView().navigationBarBackButtonHidden() : nil) {
                            PatientListItemView(patient: patient, isFromPatient: isFromPatient)
                        }
                    }
                }
                .padding()
            }
            .background(Color.prussianBlue)
            .navigationTitle("Patients List")
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

//MARK: - ItemView

struct PatientListItemView: View {
    
    var patient: PatientModel
    var isFromPatient: Bool
    
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
                Text("\(isFromPatient ? "Doctor:" : "Patient:") \(patient.patientName)")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("Last Visit: \(patient.lastVisit)")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }

            Spacer()
        }
        .padding()
        .background(Color.lightSky)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
    }
}

//MARK: - Preview

#Preview {
    PatientsListView(isFromPatient: false)
}

//MARK: - Model

struct PatientModel: Identifiable {
    var id: UUID
    var patientName: String
    var lastVisit: String
}
