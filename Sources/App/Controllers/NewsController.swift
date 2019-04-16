//
//  NewsController.swift
//  App
//
//  Created by Pedro Carrasco on 13/04/2019.
//

import Vapor
import Fluent

// MARK: - NewsController
struct NewsController: RouteCollection {
    
    // MARK: Boot
    func boot(router: Router) throws {
        let routes = router.grouped("news")
        routes.get(use: news)
        routes.post(New.self, use: createNew)
        routes.put(New.parameter, use: updateNew)
        routes.delete(New.parameter, use: deleteNew)
    }
}

// MARK: - GET
extension NewsController {
    
    func news(_ req: Request) throws -> Future<[New]> {
        return New.query(on: req)
            .sort(\.date)
            .all()
    }
}

// MARK: - POST
extension NewsController {
    
    func createNew(_ req: Request, data: New) throws -> Future<New> {
        return data.save(on: req)
    }
}

// MARK: - PUT
extension NewsController {
    
    func updateNew(_ req: Request) throws -> Future<New> {
        return try flatMap(to: New.self, req.parameters.next(New.self), req.content.decode(New.self)) {
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
