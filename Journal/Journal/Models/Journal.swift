//
//  Journal.swift
//  Journal
//
//  Created by Mike Conner on 4/20/21.
//

import Foundation

class Journal: Codable {
        
    //MARK: - Properties
    let uuid: String
    let title: String
    var entries: [Entry] = []
    
    //MARK: - Initializer
    init(title: String, uuid: String = UUID().uuidString) {
        self.title = title
        self.uuid = uuid
    }
}

extension Journal: Equatable {
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        lhs.uuid == rhs.uuid
    }
}
