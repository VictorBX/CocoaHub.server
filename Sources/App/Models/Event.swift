//
//  Event.swift
//  App
//
//  Created by Pedro Carrasco on 12/04/2019.
//

import Vapor
import FluentMySQL

final class Event: MySQLModel {
    var id: Int?
    var name: String
    var logo: String
    var tags: [String]
    var startDate: Date
    var endDate: Date
    
    init(name: String, logo: String, tags: [String], startDate: Date, endDate: Date) {
        self.name = name
        self.logo = logo
        self.tags = Tags.allowedTags(from: tags, of: .event)
        self.startDate = startDate
        self.endDate = endDate
    }
}

extension Event: Content {}

extension Event: Migration {}

extension Event: Parameter {}

extension Event {
    
    @discardableResult
    func update(with event: Event) -> Event {
        name = event.name
        logo = event.logo
        tags = event.tags
        startDate = event.startDate
        endDate = event.endDate
        
        return self
    }
}
