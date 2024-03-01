//
//  DoctorProfileView.swift
//  NeuroHelp
//
//  Created by Hamza Javaid on 28/02/2024.
//

import SwiftUI

struct DoctorProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 5)
                    .foregroundColor(.white)
                
                Text("Dr. John Doe")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .foregroundColor(.white)
                
                Text("Experienced and compassionate doctor with a focus on patient care.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)
                    .padding(.top, 5)
                
                Image(systemName: "book.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                    .padding(.top, 10)
                    .foregroundColor(.white)
                
                Text("Specialization: Cardiology")
                    .font(.headline)
                    .padding(.top, 5)
                    .foregroundColor(.white)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Patient Comments:")
                        .font(.headline)
                        .padding(.bottom, 5)
                        .foregroundColor(.white)
                    
                    ForEach(1...5, id: \.self) { index in
                        CommentView(comment: "Great doctor! Very knowledgeable and caring.")
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                Spacer()
            }
            .padding(.vertical, 20)
            .background(Color.prussianBlue) 
            .navigationTitle("Profile")
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

struct CommentView: View {
    var comment: String
    
    var body: some View {
        Text("• \(comment)")
            .font(.body)
            .foregroundColor(.gray)
    }
}

struct DoctorProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorProfileView()
    }
}
