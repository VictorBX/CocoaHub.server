//
//  NewDefault.swift
//  App
//
//  Created by Pedro Carrasco on 07/08/2019.
//

import Vapor
import FluentMySQL
import Pagination

// MARK: - NewDefault
final class NewDefault {
    
    // MARK: Properties
    let title: String
    let description: String
    let url: String
    let tags: [String]
    let curator: Person
    
    // MARK: Init
    init(title: String, description: String, url: String, tags: [String], curator: Person) {
        self.title = title
        self.description = description
        self.url = url
        self.tags = Tags.allowedTags(from: tags, of: .new)
        self.curator = curator
    }
}

// MARK: - Content
extension NewDefault: Content {}
