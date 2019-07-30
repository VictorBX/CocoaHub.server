import Vapor

// MARK: - Routes
public func routes(_ router: Router) throws {
    let controllers = [
        EventsController(),
        NewsController(),
        ArticlesController(),
        ContributorsController(),
        RecommendationsController()
    ]

    controllers.forEach {
        try router.register(collection: $0)
    }
}
