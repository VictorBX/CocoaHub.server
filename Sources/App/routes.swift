import Vapor

public func routes(_ router: Router) throws {
    let eventsController = EventsController()
    try router.register(collection: eventsController)
    
    let newsController = NewsController()
    try router.register(collection: newsController)
    
    let articlesController = ArticlesController()
    try router.register(collection: articlesController)
}