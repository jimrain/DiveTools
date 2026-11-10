//
//  LocalChecklistContainerView.swift
//  DiveTools
//
//  Created by Jim Rainville on 10/17/26.
//

import SwiftUI

struct LocalChecklistContainerView: View {
    @State private var checklists: [Checklist]? = nil
    @State private var checkListId: Int = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker("Checklist", selection: $checkListId) {
                Text("Gear up and Dry Checks").tag(0)
                Text("Pre-Dive Checks").tag(1)
            }
            .pickerStyle(.segmented)
            .background(Color.blue)
            .cornerRadius(20)
        }
        Group {
            if let checklists = checklists {
                // Pass the successfully loaded data to your list view
                // ChecklistView(checklist: checklist)
                ExpandingChecklistView(checklist: checklists[checkListId])
            } else {
                // Show a loading screen or placeholder if the file hasn't loaded yet
                ContentUnavailableView(
                    "No Checklist Found",
                    systemImage: "doc.text.magnifyingglass",
                    description: Text("Verify checklist.json is added to your app bundle target.")
                )
            }
        }
        // Load the local file right when this view appears
        .onAppear {
            self.checklists = DataLoader.loadChecklists()
        }
    }
}
