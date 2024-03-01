//
//  ChartView.swift
//  NeuroHelp
//
//  Created by Hamza Javaid on 28/02/2024.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @State private var selectedTime = Date.now
    
    var body: some View {
        VStack {
            Chart {
                BarMark(
                    x: .value("Day", "1"),
                    y: .value("Expense", 50)
                )
                
                BarMark(
                    x: .value("Day", "2"),
                    y: .value("Expense", 110)
                )
                
                BarMark(
                    x: .value("Day", "3"),
                    y: .value("Expense", 100)
                )
                BarMark(
                    x: .value("Day", "4"),
                    y: .value("Expense", 150)
                )
                BarMark(
                    x: .value("Day", "5"),
                    y: .value("Expense", 300)
                )
                BarMark(
                    x: .value("Day", "6"),
                    y: .value("Expense", 200)
                )
                BarMark(
                    x: .value("Day", "7"),
                    y: .value("Expense", 250)
                )
                BarMark(
                    x: .value("Day", "8"),
                    y: .value("Expense", 10)
                )
                
                BarMark(
                    x: .value("Day", "9"),
                    y: .value("Expense", 80)
                )
                BarMark(
                    x: .value("Day", "10"),
                    y: .value("Expense", 250)
                )
            }
        }
        .padding()
        .frame(maxWidth: 400, maxHeight: 350)
        .background(Color(.systemGray6))
    }
}

#Preview {
    ChartView()
}
