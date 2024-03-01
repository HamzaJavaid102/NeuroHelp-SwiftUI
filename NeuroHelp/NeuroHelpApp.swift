//
//  NeuroHelpApp.swift
//  NeuroHelp
//
//  Created by Hamza Javaid on 17/02/2024.
//

import SwiftUI

@main
struct NeuroHelpApp: App {
    
    @State private var isLoggedIn = false
    @State private var isDoctor = true
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                if isDoctor {
                    DoctorHome().navigationBarBackButtonHidden()
                } else {
                    PatientHome().navigationBarBackButtonHidden()
                }
            } else {
                LoginView(isLoggedIn: $isLoggedIn, isDoctor: $isDoctor)
            }
        }
    }
}
