//
//  DoctorSessionView.swift
//  NeuroHelp
//
//  Created by Hamza Javaid on 26/02/2024.
//

import SwiftUI

struct CalendarSessionView: View {
    
    @State private var selectedDate: Date = Date()
    @Environment(\.presentationMode) var presentationMode
    
    var cellTitle: String
    
    init(cellTitle: String) {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        self.cellTitle = cellTitle
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                CalendarHeader(selectedDate: $selectedDate)
                CalendarDays(selectedDate: $selectedDate)
                SessionsListView(cellTitle: cellTitle)
            }
            .background(Color.prussianBlue)
            .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
            .navigationTitle("Sessions")
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

struct CalendarHeader: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            Text("Selected Date: \(selectedDate, formatter: dateFormatter)")
                .font(.headline)
                .padding(.bottom, 8)
        }
        .foregroundColor(.white)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
}

struct CalendarDays: View {
    
    @Binding var selectedDate: Date
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(getDaysInWeek(date: selectedDate), id: \.self) { day in
                Button(action: {
                    selectedDate = day
                }) {
                    Text("\(day, formatter: dayFormatter)")
                        .frame(width: 30, height: 30)
                        .padding(8)
                        .background(selectedDate.isSameDay(as: day) ? Color.lightSky : Color.clear)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.bottom, 16)
    }
    private func getDaysInWeek(date: Date) -> [Date] {
        let calendar = Calendar.current
        let currentDate = calendar.startOfDay(for: Date())
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
        let days = (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
        return Array(days.prefix(7))
    }
    
    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
}

struct SessionsListView: View {
    
    var cellTitle: String
    var sessions: [SessionModel] = [
        SessionModel(id: UUID(), patientName: "John Doe", time: "09:00"),
        SessionModel(id: UUID(), patientName: "Jane Doe", time: "10:30"),
        SessionModel(id: UUID(), patientName: "Alce", time: "14:00"),
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(sessions) { session in
                    NavigationLink (  destination: DoctorProfileView().navigationBarBackButtonHidden(),
                                      label:{
                        SessionListItemView(session: session, nameTitle: cellTitle)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.lightSky)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
                        .foregroundColor(.white)}
                    )
                    
                }
            }
            .padding()
        }
        .background(Color.prussianBlue)
    }
}

struct SessionListItemView: View {
    
    var session: SessionModel
    var nameTitle: String
    
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
                Text("\(nameTitle) \(session.patientName)")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("Time: \(session.time)")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
    }
}

extension Date {
    func isSameDay(as date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
}

struct SessionModel: Identifiable {
    var id: UUID
    var patientName: String
    var time: String
}


struct CalendarSessionView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarSessionView(cellTitle: "Patient:")
    }
}

