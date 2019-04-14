//
//  ArticlesController.swift
//  App
//
//  Created by Pedro Carrasco on 14/04/2019.
//

import Vapor
import Fluent

struct ArticlesController: RouteCollection {
    
    func boot(router: Router) throws {
        let routes = router.grouped("articlesEditions")
        routes.get(use: editions)
        routes.get(ArticlesEdition.parameter, "articles", use: articles)
        routes.post(ArticlesEdition.self, use: createEdition)
        routes.post(Article.self, use: createArticle)
    }
}

extension ArticlesController {
    
    func editions(_ req: Request) throws -> Future<[ArticlesEdition]> {
        return ArticlesEdition.query(on: req).all()
    }
    
    func articles(_ req: Request) throws -> Future<[Article]> {
        return try req.parameters
            .next(ArticlesEdition.self)
            .flatMap(to: [Article].self) { try $0.articles.query(on: req).all() }
    }
    
    func createEdition(_ req: Request, data: ArticlesEdition) throws -> Future<ArticlesEdition> {
        return data.save(on: req)
    }
    
    func createArticle(_ req: Request, data: Article) throws -> Future<Article> {
        return data.save(on: req)
    }
}
