//
//  ContentView.swift
//  DiveTools
//
//  Created by Jim Rainville on 10/13/26.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("PPO2", systemImage: "water.waves.and.arrow.trianglehead.down", value: 0) {
                PPO2View()
            }
            // .badge(2) // Adds a notification badge
            
            Tab("SCR", systemImage: "figure.pool.swim", value: 1) {
                SCRView()
            }
            
            Tab("Checks", systemImage: "list.bullet.clipboard", value: 2) {
                LocalChecklistContainerView()
            }
            
            Tab("Settings", systemImage: "gear", value: 3) {
                SettingsView()
            }
        }
    }
}

#Preview {
    MainView()
}
