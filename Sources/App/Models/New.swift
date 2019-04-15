//
//  New.swift
//  App
//
//  Created by Pedro Carrasco on 13/04/2019.
//

import Vapor
import FluentMySQL

final class New: MySQLModel {
    var id: Int?
    var title: String
    var description: String
    var date: Date
    var uri: String
    var tags: [String]
    
    init(title: String, description: String, date: Date, uri: String, tags: [String]) {
        self.title = title
        self.description = description
        self.date = date
        self.uri = uri
        self.tags = Tags.allowedTags(from: tags, of: .new)
    }
}

extension New: Content {}

extension New: Migration {}

extension New: Parameter {}

extension New {
    
    @discardableResult
    func update(with new: New) -> New {
        title = new.title
        description = new.description
        date = new.date
        uri = new.uri
        tags = new.tags
        
        return self
    }
}
