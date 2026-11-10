//
//  PP02View.swift
//  DiveTools
//
//  Created by Jim Rainville on 10/13/26.
//

import SwiftUI

struct PPO2View: View {
    let maxPO2: Double = 1.4 // Should this be adjustable?
    let depthPerAtm: Double = 34
    
    @State private var depth: Double = 34
    @State private var percentO2 = 21.0
    
    var atmos: Double {
        return depth / depthPerAtm + 1
    }
    
    var pO2: Double {
        return (percentO2 / 100) * atmos
    }
    
    var mod: Double {
        return (maxPO2 / (percentO2 / 100) - 1) * depthPerAtm
    }
    
    var body: some View {
        
        Form {
            HStack {
                Text("Percent O2:")
                TextField("Percent O2", value: $percentO2, formatter: {
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .decimal
                    return formatter
                    
                } ())
            }
            
            HStack {
                Text("Depth:")
                TextField("Depth", value: $depth, formatter: {
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .decimal
                    return formatter
                } ())
            }
            Text("Partial Pressure of O2: \(pO2, specifier: "%.2f")")
            Text("MOD: \(mod, specifier: "%.2f") feet")
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
    PPO2View()
}
