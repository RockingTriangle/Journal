//
//  EntryController.swift
//  Journal
//
//  Created by Mike Conner on 4/19/21.
//

import Foundation

class EntryController {
    //MARK: - Properties
    static let sharedInstance = EntryController()
    var entries: [Entry] = []
    
    //MARK: - Functions (CRUD)
    ///Create
    func createEntryWith(title: String, and body: String) {
        let newEntry = Entry(title: title, body: body)
        entries.append(newEntry)
        saveToPersistenceStore()
    }
    
    ///Delete
    func delete(entry: Entry) {
        guard let index = entries.firstIndex(of: entry) else { return }
        entries.remove(at: index)
        saveToPersistenceStore()
    }
    
    //MARK: - Persistance
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Journal.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error encoding songs: \(error.localizedDescription)\n\n    \(error)")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            entries = try JSONDecoder().decode([Entry].self, from: data)
        } catch {
            print("Error decoding songs: \(error.localizedDescription)\n\n    \(error)")
        }
    }
}
