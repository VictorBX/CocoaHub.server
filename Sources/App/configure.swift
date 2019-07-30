import FluentMySQL
import Vapor

// MARK: - Configure
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers
    try services.register(FluentMySQLProvider())
    
    // Register routes to the router
    services.register(Router.self) { c -> EngineRouter in
        let router = EngineRouter.default()
        try routes(router)
        return router
    }
    
    // Register middleware
    services.register(LogMiddleware.self)
    services.register(SecretMiddleware.self)
    
    // Configure a database
    var databases = DatabasesConfig()
    let databaseConfig = MySQLDatabaseConfig(hostname: Environment.hostname,
                                             username: Environment.user,
                                             password: Environment.password,
                                             database: Environment.database)
    
    let database = MySQLDatabase(config: databaseConfig)
    databases.add(database: database, as: .mysql)
    services.register(databases)
    
    /// Configure middleware
    services.register { c -> MiddlewareConfig in
        var middleware = MiddlewareConfig()
        middleware.use(LogMiddleware.self)
        middleware.use(ErrorMiddleware.self)
        return middleware
    }
    
    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Event.self, database: .mysql)
    migrations.add(model: New.self, database: .mysql)
    migrations.add(model: ArticlesEdition.self, database: .mysql)
    migrations.add(model: Article.self, database: .mysql)
    migrations.add(model: Contributor.self, database: .mysql)
    migrations.add(model: Recommendations.self, database: .mysql)
    services.register(migrations)
    
    // preferences
    config.prefer(ConsoleLogger.self, for: Logger.self)
}
