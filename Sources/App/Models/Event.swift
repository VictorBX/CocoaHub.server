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
    let name: String
    let logo: String
    let tags: [String]
    let startDate: Date
    let endDate: Date
    
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
