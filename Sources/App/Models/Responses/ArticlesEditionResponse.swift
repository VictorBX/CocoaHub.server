//
//  ArticlesEditionResponse.swift
//  App
//
//  Created by Pedro Carrasco on 30/04/2019.
//

import Vapor
import FluentMySQL
import Foundation

// MARK: - Contributor
final class ArticlesEditionResponse {
    
    // MARK: Properties
    let articles: [Article]
    let curators: [Contributor]
    
    // MARK: Init
    init(articles: [Article]) {
        self.articles = articles
        self.curators = articles.map { return $0.curator }
    }
}

// MARK: - Content
extension ArticlesEditionResponse: Content {}
