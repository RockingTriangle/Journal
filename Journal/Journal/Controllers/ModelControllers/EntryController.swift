//
//  EntryController.swift
//  Journal
//
//  Created by Mike Conner on 4/19/21.
//

import Foundation

class EntryController {
    
    //MARK: - Functions (CRUD)
    ///Create
    static func createEntryWith(journal: Journal, title: String, and body: String) {
        let newEntry = Entry(title: title, body: body)
        JournalController.shared.addEntryTo(journal: journal, entry: newEntry)
    }
    
    static func update(entry: Entry, with newTitle: String, and newBody: String) {
        entry.title = newTitle
        entry.body = newBody
        JournalController.shared.saveToPersistenceStore()
    }
    
    ///Delete
    static func delete(journal: Journal, entry: Entry) {
        JournalController.shared.removeEntryFrom(journal: journal, entry: entry)
    }
} //End of class
