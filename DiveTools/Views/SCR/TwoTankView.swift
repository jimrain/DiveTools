//
//  TwoTankView.swift
//  DiveTools
//
//  Created by Jim Rainville on 10/14/26.
//

import SwiftUI

struct TwoTankView: View {
    @State private var tank1startingPressure: Double = 3000
    @State private var tank1endingPressure: Double = 1000
    @State private var tank2startingPressure: Double = 3000
    @State private var tank2endingPressure: Double = 1000
    @Binding var gasUsed: Double
    
    private func setGasUsed() {
        gasUsed = ((tank1startingPressure - tank1endingPressure) + (tank2startingPressure - tank2endingPressure)) / 2
    }
    
    var body: some View {
        SwiftUI.Section {
            GroupBox(label: Label("Tank 1", systemImage: "1.circle")) {
                HStack {
                    Text("Starting Pressure:")
                    TextField("Starting Pressure", value: $tank1startingPressure, formatter: {
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .none
                        return formatter
                        
                    } ())
                }
                HStack {
                    Text("Ending Pressure:")
                    TextField("Ending Pressure", value: $tank1endingPressure, formatter: {
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .none
                        return formatter
                        
                    } ())
                }
            }
            GroupBox(label: Label("Tank 2", systemImage: "2.circle")) {
                HStack {
                    Text("Starting Pressure:")
                    TextField("Starting Pressure", value: $tank2startingPressure, formatter: {
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .none
                        return formatter
                        
                    } ())
                }
                HStack {
                    Text("Ending Pressure:")
                    TextField("Ending Pressure", value: $tank2endingPressure, formatter: {
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .none
                        return formatter
                        
                    } ())
                }
            }
        }
        .onAppear {
            setGasUsed()
        }
        .onChange(of: [tank1startingPressure, tank2endingPressure, tank1endingPressure, tank2startingPressure]) {
            setGasUsed()
        }
    }
}

#Preview {
    @Previewable @State var gasUsed: Double = 0
    TwoTankView(gasUsed: $gasUsed)
}
