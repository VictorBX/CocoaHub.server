//
//  EventsController.swift
//  App
//
//  Created by Pedro Carrasco on 12/04/2019.
//

import Vapor
import Fluent

struct EventsController: RouteCollection {
    
    func boot(router: Router) throws {
        let routes = router.grouped("events")
        routes.get(use: events)
        routes.post(Event.self, use: createEvent)
    }
}

extension EventsController {
    
    func events(_ req: Request) throws -> Future<[Event]> {
        return Event.query(on: req).all()
    }
    
    func createEvent(_ req: Request, data: Event) throws -> Future<Event> {
        return data.save(on: req)
    }
}
