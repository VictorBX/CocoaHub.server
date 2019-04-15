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
        routes.put(Event.parameter, use: updateEvent)
        routes.delete(Event.parameter, use: deleteEvent)
    }
}

extension EventsController {
    
    func events(_ req: Request) throws -> Future<[Event]> {
        return Event.query(on: req)
            .sort(\.startDate)
            .all()
    }
    
    func createEvent(_ req: Request, data: Event) throws -> Future<Event> {
        return data.save(on: req)
    }
    
    func updateEvent(_ req: Request) throws -> Future<Event> {
        return try flatMap(to: Event.self, req.parameters.next(Event.self), req.content.decode(Event.self)) {
            return $0.update(with: $1).save(on: req)
        }
    }
 
    func deleteEvent(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters
            .next(Event.self)
            .delete(on: req)
            .transform(to: .noContent)
    }
}
