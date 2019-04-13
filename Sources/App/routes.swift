import Vapor

public func routes(_ router: Router) throws {

    let eventsController = EventsController()
    try router.register(collection: eventsController)
}
