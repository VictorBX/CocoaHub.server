//
//  ArticleContributorPivot.swift
//  App
//
//  Created by Pedro Carrasco on 14/04/2019.
//

import Vapor
import FluentMySQL

final class ArticleContributorPivot: MySQLPivot {    
    typealias Left = Article
    typealias Right = Contributor
    
    var id: Int?
    var article: Left.ID
    var contributor: Right.ID
    
    static let leftIDKey: LeftIDKey = \.article
    static let rightIDKey: RightIDKey = \.contributor
    
    init(_ article: Left, _ contributor: Right) throws {
        self.article = try article.requireID()
        self.contributor = try contributor.requireID()
    }
}

extension ArticleContributorPivot: Migration {}

extension ArticleContributorPivot: ModifiablePivot {}

