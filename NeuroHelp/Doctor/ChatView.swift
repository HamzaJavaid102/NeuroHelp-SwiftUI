//
//  ChatView.swift
//  NeuroHelp
//
//  Created by Hamza Javaid on 23/02/2024.
//

import SwiftUI

struct ChatView: View {
    
    var chatIndex: Int
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(1..<8) { messageIndex in
                    MessageView(isUser: messageIndex % 2 == 0, messageIndex: messageIndex)
                }
            }
            .padding()
            
            Spacer()
            
            HStack {
                TextField("Type a message", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {}, label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.lightSky)
                })
            }
            .padding()
        }
        .background(Color.prussianBlue) 
        .navigationTitle("Chat \(chatIndex)")
    }
}

struct MessageView: View {
    
    var isUser: Bool
    var messageIndex: Int
    
    var body: some View {
        HStack {
            if isUser {
                Spacer()
            }
            
            Text("Message \(messageIndex)")
                .padding(10)
                .background(isUser ? Color.lightSky : Color.indigoDyo)
                .foregroundColor(.white)
                .cornerRadius(10)
            
            if !isUser {
                Spacer()
            }
        }
    }
}

#Preview {
    ChatView(chatIndex: 0)
}
