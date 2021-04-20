//
//  JournalController.swift
//  Journal
//
//  Created by Mike Conner on 4/20/21.
//

import Foundation


class JournalController {
    
    //MARK: - Properties
    static let shared = JournalController()
    var journals: [Journal] = []
    
    //MARK: - Methods
    ///CRUD
    func createJournalWith(title: String) {
        let newJournal = Journal(title: title)
        journals.append(newJournal)
        saveToPersistenceStore()
    }
    
    func removeEntryFrom(journal: Journal, entry: Entry) {
        guard let index = journal.entries.firstIndex(of: entry) else { return }
        journal.entries.remove(at: index)
        saveToPersistenceStore()
    }
    
    func addEntryTo(journal: Journal, entry: Entry) {
        journal.entries.append(entry)
        saveToPersistenceStore()
    }
    
    func delete(journal: Journal) {
        guard let index = journals.firstIndex(of: journal) else { return }
        journals.remove(at: index)
        saveToPersistenceStore()
    }
    
    //MARK: - Persistance
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Journals.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(journals)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error encoding songs: \(error.localizedDescription)\n\n \(error)")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            journals = try JSONDecoder().decode([Journal].self, from: data)
        } catch {
            print("Error decoding songs: \(error.localizedDescription)\n\n  \(error)")
        }
    }
} //End of class
