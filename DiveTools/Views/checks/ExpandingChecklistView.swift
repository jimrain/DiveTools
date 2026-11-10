//
//  ExpandingChecklistView.swift
//  DiveTools
//
//  Created by Jim Rainville on 10/17/26.
//

import SwiftUI

struct ExpandingChecklistView: View {
    let checklist: Checklist
    
    // Tracks which sections are expanded. Key is the Section UUID, value is expanded state.
    @State private var expandedSections: [UUID: Bool] = [:]
    @State private var showInfoAlert = false
    @State private var sectionDetail = ""
    @State private var sectionTitle = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(checklist.sections) { section in
                    // 1. Get a binding to the expanded state, defaulting to 'true' (expanded by default)
                    let isExpanded = Binding(
                        get: { expandedSections[section.id, default: false] },
                        set: { expandedSections[section.id] = $0 }
                    )
                    
                    // 2. Use a DisclosureGroup for the collapsing animation
                    DisclosureGroup(isExpanded: isExpanded) {
                        // Content inside the expanded section
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(section.items) { item in
                                if !item.headline.isEmpty {
                                    ChecklistRow(item: item)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    } label: {
                        // The clickable Header Row
                        Text(.init(section.title))
                            // .font(.headline)
                            .foregroundColor(.primary)
                            .padding(.vertical, 2)
                        
                        if !section.detail.isEmpty {
                            // The Info Button
                            Button(action: {
                                sectionDetail = section.detail
                                sectionTitle = section.title
                                showInfoAlert = true
                            }) {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.blue)
                                    .font(.body)
                            }
                            // CRITICAL: Prevents the button tap from collapsing/expanding the group
                            .buttonStyle(.borderless)
                        }
                        
                    }
                }
            }
            .navigationTitle(checklist.name)
            .listStyle(.sidebar) // Best visual layout style for expanding lists
            .sheet(isPresented: $showInfoAlert) {
                DetailPopupView(title: $sectionTitle, message: $sectionDetail)
                // Use adaptive sizing for a compact, alert-like appearance
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

// A reusable subview for the individual rows
struct ChecklistRow: View {
    let item: ChecklistItem
    @State private var isChecked = false
    @State private var showInfoAlert = false
    @State private var itemDetail: String = ""
    @State private var itemTitle: String = ""
    
    var body: some View {
        Button(action: { isChecked.toggle() }) {
            HStack(alignment: .top) {
                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isChecked ? .green : .gray)
                    .font(.title3)
                
                Text(item.headline)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
                
                if !item.detail.isEmpty {
                    Button(action: {
                        itemDetail = item.detail
                        itemTitle = item.headline
                        showInfoAlert = true
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.blue)
                            .font(.body)
                    }
                    // CRITICAL: Prevents the button tap from collapsing/expanding the group
                    .buttonStyle(.borderless)
                }
                
            }
        }
        .buttonStyle(.plain) // Prevents the whole row from highlighting like a classic button
        
        .sheet(isPresented: $showInfoAlert) {
            DetailPopupView(title: $itemTitle, message: $itemDetail)
            // Use adaptive sizing for a compact, alert-like appearance
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
}

struct DetailPopupView: View {
    @Binding var title: String
    @Binding var message: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text(LocalizedStringKey(title))
                .font(.headline)
            
            // ScrollView handles text wrapping and scrolling safely
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(LocalizedStringKey(message))
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 24)
            }
            // Pinned action button at the bottom
            Button(action: { dismiss() }) {
                Text("OK")
                    .font(.body)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
        .padding()
    }
}

