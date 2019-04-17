import FluentMySQL
import Vapor

// MARK: - Configure
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers
    try services.register(FluentMySQLProvider())
    
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    // Register middleware
    var middlewares = MiddlewareConfig()
    middlewares.use(ErrorMiddleware.self)
    services.register(middlewares)
    
    // Configure a database
    var databases = DatabasesConfig()
    let databaseConfig = MySQLDatabaseConfig(hostname: Environment.get("DATABASE_HOSTNAME") ?? "localhost",
                                             username: Environment.get("DATABASE_USER") ?? "vapor",
                                             password: Environment.get("DATABASE_PASSWORD") ?? "password",
                                             database: Environment.get("DATABASE_DB") ?? "cocoahub")
    
    let database = MySQLDatabase(config: databaseConfig)
    databases.add(database: database, as: .mysql)
    services.register(databases)
    
    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Event.self, database: .mysql)
    migrations.add(model: New.self, database: .mysql)
    migrations.add(model: ArticlesEdition.self, database: .mysql)
    migrations.add(model: Article.self, database: .mysql)
    migrations.add(model: Contributor.self, database: .mysql)
    services.register(migrations)
}
