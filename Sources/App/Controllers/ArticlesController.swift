//
//  ArticlesController.swift
//  App
//
//  Created by Pedro Carrasco on 14/04/2019.
//

import Vapor
import Fluent
import Pagination

// MARK: - ArticlesController
struct ArticlesController: RouteCollection {
    
    // MARK: Boot
    func boot(router: Router) throws {
        let editionsRoutes = router.grouped("articlesEditions")
        editionsRoutes.get(use: editions)
        editionsRoutes.get(ArticlesEdition.parameter, "articles", use: articles)
        editionsRoutes.group(SecretMiddleware.self) {
            $0.post(ArticlesEdition.self, use: createEdition)
            $0.put(ArticlesEdition.parameter, use: updateEdition)
            $0.delete(ArticlesEdition.parameter, use: deleteEdition)
        }
        
        let articlesRoutes = router.grouped("articles")
        articlesRoutes.get(Article.parameter, use: article)
        articlesRoutes.group(SecretMiddleware.self) {
            $0.post(Article.self, use: createArticle)
            $0.put(Article.parameter, use: updateArticle)
            $0.delete(Article.parameter, use: deleteArticle)
        }
    }
}

// MARK: - GET
extension ArticlesController {
    
    func editions(_ req: Request) throws -> Future<Paginated<ArticlesEdition>> {
        let today = Date()
        return try ArticlesEdition.query(on: req)
            .filter(\.date <= today)
            .sort(\.date, .descending)
            .paginate(for: req)
    }
    
    func articles(_ req: Request) throws -> Future<EditionDetailsOutput> {
        let edition = try req
            .parameters
            .next(ArticlesEdition.self)
        
        let articles = edition
            .flatMap(to: [Article].self) {
                try $0.articles.query(on: req)
                    .all()
        }
        
        return edition
            .and(articles)
            .map(to: EditionDetailsOutput.self) { edition, articles in
                let sortedArticles = articles.sorted(by: { (left, right) -> Bool in
                    let leftFlatTags = left.tags.joined()
                    let rightFlatTags = right.tags.joined()
                    return leftFlatTags < rightFlatTags || (leftFlatTags == rightFlatTags && left.title < right.title)
                })
                
                return EditionDetailsOutput(edition: edition, articles: sortedArticles)
        }
    }
    
    func article(_ req: Request) throws -> Future<Article> {
        return try req.parameters.next(Article.self)
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
