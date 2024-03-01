//
//  ChatListView.swift
//  NeuroHelp
//
//  Created by Hamza Javaid on 23/02/2024.
//

import SwiftUI

struct ChatListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(0..<11) { index in
                        NavigationLink(
                            destination: ChatView(chatIndex: index),
                            label: {
                                ChatListItemView(chatIndex: index)
                                    .frame(width: (UIScreen.main.bounds.width) - 60, height: 60)
                                    .padding()
                                    .background(.lightSky)
                                    .cornerRadius(10)
                                    .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
                            }
                        )
                    }
                }
                .padding()
            }
            .background(Color.prussianBlue)
            .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
            .navigationTitle("Chat List")
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

struct ChatListItemView: View {
    
    var chatIndex: Int
    
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
                Text("Chat \(chatIndex)")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("Last message preview")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding(10)
    }
}

#Preview {
    ChatListView()
}
