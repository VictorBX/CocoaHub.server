//
//  NewsController.swift
//  App
//
//  Created by Pedro Carrasco on 13/04/2019.
//

import Vapor
import Fluent

struct NewsController: RouteCollection {
    
    func boot(router: Router) throws {
        let routes = router.grouped("news")
        routes.get(use: news)
        routes.post(New.self, use: createNew)
    }
}

extension NewsController {
    
    func news(_ req: Request) throws -> Future<[New]> {
        return New.query(on: req).all()
    }
    
    func createNew(_ req: Request, data: New) throws -> Future<New> {
        return data.save(on: req)
    }
}

