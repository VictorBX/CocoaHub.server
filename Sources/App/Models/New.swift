//
//  New.swift
//  App
//
//  Created by Pedro Carrasco on 13/04/2019.
//

import Vapor
import FluentMySQL
import Pagination

// MARK: - New
final class New {
    
    // MARK: Properties
    var id: Int?
    var title: String
    var description: String
    var date: Date
    var uri: String
    var tags: [String]
    var curator: Person
    
    // MARK: Init
    init(title: String, description: String, date: Date, uri: String, tags: [String], curator: Person) {
        self.title = title
        self.description = description
        self.date = date
        self.uri = uri
        self.tags = Tags.allowedTags(from: tags, of: .new)
        self.curator = curator
    }
}

// MARK: - MySQLModel
extension New: MySQLModel {}

// MARK: - Content
extension New: Content {}

// MARK: - Migration
extension New: Migration {}

// MARK: - Parameter
extension New: Parameter {}

// MARK: - Paginatable
extension New: Paginatable {}

// MARK: - Update
extension New {
    
    @discardableResult
    func update(with new: New) -> New {
        title = new.title
        description = new.description
        date = new.date
        uri = new.uri
        tags = new.tags
        curator = new.curator
        
        return self
    }
}
