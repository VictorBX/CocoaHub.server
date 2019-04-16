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
    var edition: ArticlesEdition.ID
    
    // MARK: Relational Properties
    var author: Siblings<Article, Contributor, ArticleContributorPivot> {
        return siblings()
    }
    
    // MARK: Init
    init(title: String, tags: [String], edition: ArticlesEdition.ID) {
        self.title = title
        self.tags = Tags.allowedTags(from: tags, of: .article)
        self.edition = edition
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
        
        return self
    }
}
