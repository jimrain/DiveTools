//
//  Checklist.swift
//  DiveTools
//
//  Created by Jim Rainville on 10/16/26.
//

/*
import Foundation

struct ChecklistResponse: Decodable {
    let checklist: [Checklist]
    
    enum CodingKeys: String, CodingKey {
        case checklist = "Checklist"
    }
}

struct Checklist: Decodable, Identifiable {
    let id: Int
    let name: String
    let sections: [ChecklistSection]
}

struct ChecklistSection: Decodable, Identifiable {
    var id = UUID()
    let title: String
    let detail: String
    let items: [ChecklistItem]
    
    enum CodingKeys: String, CodingKey {
        case title, detail, items
    }
}

struct ChecklistItem: Decodable, Identifiable {
    var id = UUID()
    let headline: String
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case headline, detail
    }
}
 */

import Foundation

// 1. Root wrapper to match the top-level "Checklists" key
struct ChecklistResponse: Codable {
    let checklists: [Checklist]
    
    enum CodingKeys: String, CodingKey {
        case checklists = "Checklists" // Maps capitalized JSON key to camelCase
    }
}

// 2. Individual Checklist
struct Checklist: Codable, Identifiable {
    let id: Int
    let name: String
    let sections: [ChecklistSection]
}

// 3. Section inside a Checklist
struct ChecklistSection: Codable, Identifiable {
    var id = UUID() // Generated automatically for SwiftUI Lists
    let title: String
    let detail: String
    let items: [ChecklistItem]
    
    enum CodingKeys: String, CodingKey {
        case title, detail, items
    }
}

// 4. Individual task item inside a Section
struct ChecklistItem: Codable, Identifiable {
    var id = UUID() // Generated automatically for SwiftUI Lists
    let headline: String
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case headline, detail
    }
}


