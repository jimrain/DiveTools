//
//  SCRView.swift
//  DiveTools
//
//  Created by Jim Rainville on 10/14/26.
//

import SwiftUI

struct SCRView: View {
    @State private var feetPerAtm: Double = 34
    @State private var numTanks: Int = 1
    @State private var gasUsed: Double = 0
    @State private var tankConversionFactor = 0.052
    @State private var averageDepth: Double = 0
    @State private var diveTime: Double = 60
    
    var body: some View {
            Form {
                VStack(alignment: .leading) {
                    Picker("Side of the river:", selection: $numTanks) {
                        Text("1 Tank").tag(1)
                        Text("2 Tanks").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .background(Color.blue)
                    .cornerRadius(20)
                }
                // .padding()
                
                if numTanks == 1 {
                    SingleTankView(gasUsed: $gasUsed)
                } else {
                    TwoTankView(gasUsed: $gasUsed)
                }
                
                SwiftUI.Section {
                    HStack {
                        Text("Average Depth:")
                        TextField("Average Depth", value: $averageDepth, formatter: {
                            let formatter = NumberFormatter()
                            formatter.numberStyle = .none
                            return formatter
                        } ())
                        Text("feet")
                    }
                    
                    HStack {
                        Text("Dive Time:")
                        TextField("Dive Time", value: $diveTime, formatter: {
                            let formatter = NumberFormatter()
                            formatter.numberStyle = .decimal
                            return formatter
                        } ())
                        Text("minutes")
                    }
                    
                }
                
                SwiftUI.Section {
                    let gasUsedByVolume = gasUsed * tankConversionFactor
                    let averageATM = (averageDepth / feetPerAtm + 1)
                    let underwaterRate = gasUsedByVolume / diveTime
                    let SCR = underwaterRate / averageATM
                    Text("Gas Used: \(gasUsed, specifier: "%.0f") psi or \(gasUsedByVolume, specifier: "%.2f") ft³")
                    Text("Underwater Rate: \(underwaterRate, specifier: "%.2f") ft³ / minute")
                    Text("SCR: \(SCR, specifier: "%.2f") ft³ / minute")
                }
            }
        .scrollContentBackground(.hidden)
        .background (
            LinearGradient(
                gradient: Gradient(colors: [Color.cyan.opacity(0.8), Color.blue, Color.init(red: 0, green: 0.1, blue: 0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

#Preview {
    SCRView()
}
