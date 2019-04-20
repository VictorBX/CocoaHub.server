//
//  Event.swift
//  App
//
//  Created by Pedro Carrasco on 12/04/2019.
//

import Vapor
import FluentMySQL
import Pagination

// MARK: - Event
final class Event {
    
    // MARK: Properties
    var id: Int?
    var name: String
    var logo: String
    var tags: [String]
    var uri: String
    var startDate: Date
    var endDate: Date
    
    // MARK: Init
    init(name: String, logo: String, tags: [String], uri: String, startDate: Date, endDate: Date) {
        self.name = name
        self.logo = logo
        self.tags = Tags.allowedTags(from: tags, of: .event)
        self.uri = uri
        self.startDate = startDate
        self.endDate = endDate
    }
}

// MARK: - MySQLModel
extension Event: MySQLModel {}

// MARK: - Content
extension Event: Content {}

// MARK: - Migration
extension Event: Migration {}

// MARK: - Parameter
extension Event: Parameter {}

// MARK: - Paginatable
extension Event: Paginatable {}

// MARK: - Update
extension Event {
    
    @discardableResult
    func update(with event: Event) -> Event {
        name = event.name
        logo = event.logo
        tags = event.tags
        uri = event.uri
        startDate = event.startDate
        endDate = event.endDate
        
        return self
    }
}
