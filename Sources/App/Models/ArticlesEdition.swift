//
//  ArticlesEdition.swift
//  App
//
//  Created by Pedro Carrasco on 14/04/2019.
//

import Vapor
import FluentMySQL

final class ArticlesEdition: MySQLModel {
    var id: Int?
    let title: String
    let description: String
    let date: Date
    
    var articles: Children<ArticlesEdition, Article> {
        return children(\.edition)
    }
    
    init(title: String, description: String, date: Date) {
        self.title = title
        self.description = description
        self.date = date
    }
}

extension ArticlesEdition: Content {}

extension ArticlesEdition: Migration {}

extension ArticlesEdition: Parameter {}
