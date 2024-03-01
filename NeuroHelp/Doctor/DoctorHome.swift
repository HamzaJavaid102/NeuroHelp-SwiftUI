//
//  DoctorHome.swift
//  NeuroHelp
//
//  Created by Hamza Javaid on 22/02/2024.
//

import SwiftUI

struct DoctorHome: View {
    
    @Environment(\.dismiss) private var dismiss
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                    ForEach(0..<6) { index in
                        let itemInfo = getItemInfo(for: index)
                        NavigationLink(
                            destination: itemInfo.destination,
                            label: {
                                ItemView(symbol: itemInfo.symbol, text: itemInfo.text, destination: itemInfo.destination)
                                    .frame(width: (UIScreen.main.bounds.width / 2) - 60, height: 150)
                                    .padding()
                                    .background(.lightSky)
                                    .cornerRadius(10)
                                    .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
                            }
                        )
                    }
                }
                .padding()
                
                Spacer()
            }
            .background(.prussianBlue)
            .navigationBarTitle("Hi, Doctor")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func getItemInfo(for index: Int) -> (symbol: String, text: String, destination: AnyView) {
        switch index {
        case 0:
            return ("🩺", "Doctor Session", AnyView(CalendarSessionView(cellTitle: "Patient:").navigationBarBackButtonHidden()) )
        case 1:
            return ("💬", "Chat Room", AnyView(ChatListView().navigationBarBackButtonHidden()))
        case 2:
            return ("📈", "Progress for Patients", AnyView(PatientListProgressView().navigationBarBackButtonHidden()))
        case 3:
            return ("👥", "Total Patients", AnyView(PatientsListView(isFromPatient: false).navigationBarBackButtonHidden()))
        case 4:
            return ("🏋️‍♂️", "Activity’s for patient", AnyView(WorkoutView().navigationBarBackButtonHidden()))
        case 5:
            return ("👤", "Profile", AnyView(DoctorProfileView().navigationBarBackButtonHidden()))
        default:
            return ("", "", AnyView(ChatListView()))
        }
    }
}

struct ItemView: View {
    var symbol: String
    var text: String
    var destination: AnyView
    
    var body: some View {
        VStack {
            Text(symbol)
                .font(.system(size: 30))
                .padding()
                .background(Circle().foregroundColor(Color.lightSky).opacity(0.8))
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
            
            Text(text)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.top, 8)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    DoctorHome()
}
