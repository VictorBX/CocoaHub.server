//
//  NewsController.swift
//  App
//
//  Created by Pedro Carrasco on 13/04/2019.
//

import Vapor
import Fluent
import Pagination

// MARK: - NewsController
struct NewsController: RouteCollection {
    
    // MARK: Boot
    func boot(router: Router) throws {
        let routes = router.grouped("news")
        routes.get(use: news)
        routes.get(New.parameter, use: new)
        
        routes.group(SecretMiddleware.self) {
            $0.post(NewDefault.self, use: createNew)
            $0.put(New.parameter, use: updateNew)
            $0.delete(New.parameter, use: deleteNew)
        }
    }
}

// MARK: - GET
extension NewsController {
    
    func news(_ req: Request) throws -> Future<Paginated<New>> {
        return try New.query(on: req)
            .sort(\.date, .descending)
            .paginate(for: req)
    }
    
    func new(_ req: Request) throws -> Future<New> {
        return try req.parameters.next(New.self)
    }
}

// MARK: - POST
extension NewsController {
    
    func createNew(_ req: Request, data: NewDefault) throws -> Future<New> {
        let new = New(title: data.title, description: data.description, date: Date(), url: data.url, tags: data.tags, curator: data.curator)
        return new.create(on: req)
    }
}

// MARK: - PUT
extension NewsController {
    
    func updateNew(_ req: Request) throws -> Future<New> {
        return try flatMap(to: New.self, req.parameters.next(New.self), req.content.decode(NewDefault.self)) {
            return $0.update(with: $1).save(on: req)
        }
    }
}

// MARK: - DELETE
extension NewsController {
    
    func deleteNew(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters
            .next(New.self)
            .delete(on: req)
            .transform(to: .noContent)
    }
}
