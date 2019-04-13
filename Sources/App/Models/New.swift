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
    let title: String
    let description: String
    let date: Date
    let uri: String
    let tags: [String]
    
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
