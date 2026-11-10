//
//  ChecklistView.swift
//  DiveTools
//
//  Created by Jim Rainville on 10/17/26.
//

import SwiftUI

struct ChecklistView: View {
    // In a real app, you would fetch this from an API or local file
    let checklist: Checklist
    
    var body: some View {
        NavigationStack {
            List {
                // Loop through each section in the checklist
                ForEach(checklist.sections) { section in
                    SwiftUI.Section(header: Text(.init(section.title))) {
                        
                        // Optional: Show section detail if it's not empty
                        if !section.detail.isEmpty {
                            Text(section.detail)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.vertical, 4)
                        }
                        
                        // Loop through items inside this section
                        ForEach(section.items) { item in
                            if !item.headline.isEmpty {
                                ChecklistRow(item: item)
                            }
                        }
                    }
                }
            }
            .navigationTitle(checklist.name)
            .listStyle(.insetGrouped)
        }
    }
}

