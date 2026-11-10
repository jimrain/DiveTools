//
//  DataLoader.swift
//  DiveTools
//
//  Created by Jim Rainville on 10/17/26.
//
import Foundation

struct DataLoader {
    static func loadChecklists() -> [Checklist]? {
        // 1. Locate the file in the app bundle
        guard let url = Bundle.main.url(forResource: "checklists", withExtension: "json") else {
            print("Error: Could not find checklist.json in the bundle.")
            return nil
        }
        
        do {
            // 2. Load the file contents into Data
            let data = try Data(contentsOf: url)
            
            // 3. Decode the data using your models
            let decoder = JSONDecoder()
            let response = try decoder.decode(ChecklistResponse.self, from: data)
            
            return response.checklists
        } catch {
            print("Error loading or parsing JSON: \(error)")
            return nil
        }
    }
}

