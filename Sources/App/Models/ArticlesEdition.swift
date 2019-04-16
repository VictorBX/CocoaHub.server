//
//  ArticlesEdition.swift
//  App
//
//  Created by Pedro Carrasco on 14/04/2019.
//

import Vapor
import FluentMySQL

// MARK: - ArticlesEdition
final class ArticlesEdition {
    
    // MARK: Properties
    var id: Int?
    var title: String
    var description: String
    var date: Date
    
    // MARK: Relational Properties
    var articles: Children<ArticlesEdition, Article> {
        return children(\.edition)
    }
    
    // MARK: Init
    init(title: String, description: String, date: Date) {
        self.title = title
        self.description = description
        self.date = date
    }
}

// MARK: - MySQLModel
extension ArticlesEdition: MySQLModel {}

// MARK: - Content
extension ArticlesEdition: Content {}

// MARK: - Migration
extension ArticlesEdition: Migration {}

// MARK: - Parameter
extension ArticlesEdition: Parameter {}

// MARK: - Update
extension ArticlesEdition {
    
    @discardableResult
    func update(with edition: ArticlesEdition) -> ArticlesEdition {
        title = edition.title
        description = edition.description
        date = edition.date
        
        return self
    }
}
