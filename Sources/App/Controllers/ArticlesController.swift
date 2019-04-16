//
//  ArticlesController.swift
//  App
//
//  Created by Pedro Carrasco on 14/04/2019.
//

import Vapor
import Fluent

// MARK: - ArticlesController
struct ArticlesController: RouteCollection {
    
    // MARK: Boot
    func boot(router: Router) throws {
        let routes = router.grouped("articlesEditions")
        routes.get(use: editions)
        routes.get(ArticlesEdition.parameter, "articles", use: articles)
        routes.post(ArticlesEdition.self, use: createEdition)
        routes.post(Article.self, use: createArticle)
        routes.put(ArticlesEdition.parameter, use: updateEdition)
        routes.put(Article.parameter, use: updateArticle)
        routes.delete(ArticlesEdition.parameter, use: deleteEdition)
        routes.delete(Article.parameter, use: deleteArticle)
    }
}

// MARK: - GET
extension ArticlesController {
    
    func editions(_ req: Request) throws -> Future<[ArticlesEdition]> {
        return ArticlesEdition.query(on: req)
            .sort(\.date)
            .all()
    }
    
    func articles(_ req: Request) throws -> Future<[Article]> {
        return try req.parameters
            .next(ArticlesEdition.self)
            .flatMap(to: [Article].self) { try $0.articles.query(on: req).all() }
    }
}

// MARK: - POST
extension ArticlesController {
    
    func createEdition(_ req: Request, data: ArticlesEdition) throws -> Future<ArticlesEdition> {
        return data.save(on: req)
    }
    
    func createArticle(_ req: Request, data: Article) throws -> Future<Article> {
        return data.save(on: req)
    }
}

// MARK: - PUT
extension ArticlesController {
    
    func updateEdition(_ req: Request) throws -> Future<ArticlesEdition> {
        return try flatMap(to: ArticlesEdition.self, req.parameters.next(ArticlesEdition.self), req.content.decode(ArticlesEdition.self)) {
            return $0.update(with: $1).save(on: req)
        }
    }
    
    func updateArticle(_ req: Request) throws -> Future<Article> {
        return try flatMap(to: Article.self, req.parameters.next(Article.self), req.content.decode(Article.self)) {
            return $0.update(with: $1).save(on: req)
        }
    }
}

// MARK: - DELETE
extension ArticlesController {
    
    func deleteEdition(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters
            .next(ArticlesEdition.self)
            .delete(on: req)
            .transform(to: .noContent)
    }
    
    func deleteArticle(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters
            .next(Article.self)
            .delete(on: req)
            .transform(to: .noContent)
    }
}
