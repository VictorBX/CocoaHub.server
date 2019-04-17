//
//  Article.swift
//  App
//
//  Created by Pedro Carrasco on 14/04/2019.
//

import Vapor
import FluentMySQL

// MARK: - Article
final class Article {
    
    // MARK: Properties
    var id: Int?
    var title: String
    var tags: [String]
    var author: Contributor
    var curator: Contributor
    var edition: ArticlesEdition.ID
    
    // MARK: Init
    init(title: String, tags: [String], author: Contributor, curator: Contributor, edition: ArticlesEdition.ID) {
        self.title = title
        self.tags = Tags.allowedTags(from: tags, of: .article)
        self.edition = edition
        self.author = author
        self.curator = curator
    }
}

// MARK: - MySQLModel
extension Article: MySQLModel {}

// MARK: - Content
extension Article: Content {}

// MARK: - Parameter
extension Article: Parameter {}

// MARK: - Migration
extension Article: Migration {
    
    static func prepare(on connection: MySQLConnection) -> Future<Void> {
        return Database.create(self, on: connection) { builder in
            try addProperties(to: builder)
            builder.reference(from: \.edition, to: \ArticlesEdition.id)
        }
    }
}

// MARK: - Update
extension Article {
    
    @discardableResult
    func update(with article: Article) -> Article {
        title = article.title
        tags = article.tags
        edition = article.edition
        curator = article.curator
        
        return self
    }
}
