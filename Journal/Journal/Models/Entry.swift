//
//  Entry.swift
//  Journal
//
//  Created by Mike Conner on 4/19/21.
//

import Foundation

class Entry: Codable {
    
    //MARK: - Properties
    let uuid: String
    var title: String
    var body: String
    let entryCreationTimestamp: Date
    
    //MARK: - Initializer
    init(uuid: String = UUID().uuidString, title: String, body: String, entryCreationTimestamp: Date = Date()) {
        self.uuid = uuid
        self.title = title
        self.body = body
        self.entryCreationTimestamp = entryCreationTimestamp
    }
} // End of class

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        lhs.uuid == rhs.uuid
    }
} // End of extension
