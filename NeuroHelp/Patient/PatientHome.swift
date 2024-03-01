//
//  PatientHome.swift
//  NeuroHelp
//
//  Created by Hamza Javaid on 22/02/2024.
//

import SwiftUI

struct PatientHome: View {
    
    @State private var progress: CGFloat = 0.5
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ChartView()
                    .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width  - 100 )
                GridView()
            }
            .padding()
            .background(.prussianBlue)
            .navigationBarTitle("Hi,Jhon")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PatientHome()
    }
}

struct SpeedometerShape: View {
    @State var progressValue: Float = 0.3
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var degrees: Double = -110
    
    var body: some View {
        VStack {
            ZStack {
                ProgressBar(progress: self.$progressValue)
                    .frame(width: 250.0, height: 250.0)
                    .padding(40.0).onReceive(timer) { _ in
                        withAnimation {
                            if progressValue < 0.8999996 {
                                progressValue += 0.0275
                            }
                        }
                    }
            }
            Spacer()
        }
    }
}

struct GridView: View {
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                ForEach(0..<4) { index in
                    let itemInfo = getItemInfo(for: index)
                    NavigationLink(
                        destination: itemInfo.destination,
                        label: {
                            ItemView(symbol: itemInfo.symbol, text: itemInfo.text, destination: itemInfo.destination)
                                .frame(width: (UIScreen.main.bounds.width / 2) - 80, height: 150)
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
    }
    
    func getItemInfo(for index: Int) -> (symbol: String, text: String, destination: AnyView) {
        switch index {
        case 0:
            return ("🩺", "Todo List", AnyView(TodoView().navigationBarBackButtonHidden()) )
        case 1:
            return ("👤", "Doctors", AnyView(PatientsListView(isFromPatient: true).navigationBarBackButtonHidden()))
        case 2:
            return ("👥", "Sessions", AnyView(CalendarSessionView(cellTitle: "Doctor:").navigationBarBackButtonHidden()))
        case 3:
            return ("🏋️‍♂️", "Workouts", AnyView(TodoView().navigationBarBackButtonHidden()))
        default:
            return ("", "", AnyView(TodoView().navigationBarBackButtonHidden()))
        }
    }
}

struct GridItemView: View {
    
    var title: String
    
    var body: some View {
        VStack {
            Image(systemName: "square.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
                .padding()
            
            Text(title)
                .font(.caption)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
    }
}

struct ProgressBar: View {
    
    @Binding var progress: Float
    
    var body: some View {Image(systemName: "octagon.fill")
        ZStack {
            Circle()
                .trim(from: 0.3, to: 0.9)
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .opacity(0.3)
                .foregroundColor(Color.gray)
                .rotationEffect(.degrees(54.5))
            
            Circle()
                .trim(from: 0.3, to: CGFloat(self.progress))
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .fill(AngularGradient(gradient: Gradient(stops: [
                    .init(color: Color.lightSky, location: 0.39000002),]), center: .center))
                .rotationEffect(.degrees(54.5))
            
            VStack{
                Text("824").font(Font.system(size: 44)).bold().foregroundColor(Color.init("314058"))
                Text("Great Score!").bold().foregroundColor(Color.init("32E1A0"))
            }
        }
    }
}

//chart.xyaxis.line
//ellipsis.message.fill
