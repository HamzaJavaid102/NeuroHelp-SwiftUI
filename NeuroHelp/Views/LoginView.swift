//
//  LoginView.swift
//  NeuroHelp
//
//  Created by Hamza Javaid on 17/02/2024.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var isLoggedIn: Bool
    @Binding var isDoctor: Bool
    @State private var selectedSegment = 0
    @State var email: String = ""
    @State var password: String = ""
    let segments = ["Doctor", "Patient"]
    
    
    var body: some View {
        NavigationView {
            VStack (spacing: 20) {
                Picker("Segments", selection: $selectedSegment) {
                    ForEach(0..<segments.count) { index in
                        Text(self.segments[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectedSegment) { newIndex in
                    if newIndex == 0 {
                        isDoctor = true
                    } else {
                        isDoctor = false
                    }
                }
                
                Spacer()
                
                Image("logo")
                    .resizable()
                    .frame(width: 150,height: 150)
                    .cornerRadius(10)
                
                VStack {
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(.top, 20)
                    
                    Divider()
                    
                    SecureField(
                        "Password", text: $password)
                    .padding(.top, 20)
                    
                    Divider()
                }
                
                Spacer()
                
                Button(
                    action: {
                        isLoggedIn = true
                    },
                    label: {
                        Text("Login")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .foregroundColor(Color.white)
                            .background(Color.prussianBlue)
                            .cornerRadius(10)
                    }
                )

            }
            .padding(30)
        }
    }
}

//#Preview {
////    LoginView(isLoggedIn: false)
//}
