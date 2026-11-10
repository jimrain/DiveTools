//
//  SingleTankView.swift
//  DiveTools
//
//  Created by Jim Rainville on 10/14/26.
//

import SwiftUI

struct SingleTankView: View {
    @State private var startingPressure: Double = 3000
    @State private var endingPressure: Double = 1000
    
    @Binding var gasUsed: Double
    
    private func setGasUsed() {
        gasUsed = startingPressure - endingPressure
    }
    
    var body: some View {
        SwiftUI.Section {
            HStack {
                Text("Starting Pressure:")
                TextField("Starting Pressure", value: $startingPressure, formatter: {
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .none
                    return formatter
                    
                } ())
            }
            HStack {
                Text("Ending Pressure:")
                TextField("Ending Pressure", value: $endingPressure, formatter: {
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .none
                    return formatter
                    
                } ())
            }
        }
        .onAppear {
            setGasUsed()
        }
        .onChange(of: [startingPressure, endingPressure]) {
            setGasUsed()
        }
    }
}

#Preview {
    @Previewable @State var gasUsed: Double = 0
    SingleTankView(gasUsed: $gasUsed)
}
