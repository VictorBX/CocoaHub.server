//
//  Article.swift
//  App
//
//  Created by Pedro Carrasco on 14/04/2019.
//

import Vapor
import FluentMySQL

final class Article: MySQLModel {
    var id: Int?
    let title: String
    let tags: [String]
    var edition: ArticlesEdition.ID
    
    var author: Siblings<Article, Contributor, ArticleContributorPivot> {
        return siblings()
    }
    
    init(title: String, tags: [String], edition: ArticlesEdition.ID) {
        self.title = title
        self.tags = Tags.allowedTags(from: tags, of: .article)
        self.edition = edition
    }
}

extension Article: Content {}

extension Article: Migration {
    
    static func prepare(on connection: MySQLConnection) -> Future<Void> {
        return Database.create(self, on: connection) { builder in
            try addProperties(to: builder)
            builder.reference(from: \.edition, to: \ArticlesEdition.id)
        }
    }
}
