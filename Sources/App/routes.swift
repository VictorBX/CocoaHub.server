import Vapor

// MARK: - Routes
public func routes(_ router: Router) throws {
    let eventsController = EventsController()
    try router.register(collection: eventsController)
    
    let newsController = NewsController()
    try router.register(collection: newsController)
    
    let articlesController = ArticlesController()
    try router.register(collection: articlesController)
    
    let contributorsController = ContributorsController()
    try router.register(collection: contributorsController)
}
