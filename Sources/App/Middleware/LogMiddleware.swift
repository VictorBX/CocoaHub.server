//
//  LogMiddleware.swift
//  App
//
//  Created by Pedro Carrasco on 18/04/2019.
//

import Vapor

// MARK: - LogMiddleware
final class LogMiddleware {
    
    // MARK: Private Properties
    private let logger: Logger
    
    // MARK: Init
    init(with logger: Logger) {
        self.logger = logger
    }
}

// MARK: - Middleware
extension LogMiddleware: Middleware {
    
    func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {
        let start = Date()
        return try next.respond(to: request).map {
            self.log($0, start: start, for: request)
            return $0
        }
    }
}

// MARK: - ServiceType
extension LogMiddleware: ServiceType {
    
    static func makeService(for container: Container) throws -> LogMiddleware {
        return try LogMiddleware(with: container.make())
    }
}

// MARK: - Private functions
private extension LogMiddleware {
    
    func log(_ response: Response, start: Date, for request: Request) {
        let requestInfo = "\(request.http.method.string) \(request.http.url.path)"
        let responseInfo = "\(response.http.status.code) " + "\(response.http.status.reasonPhrase)"
        logger.info("\(requestInfo) -> \(responseInfo) [\(Date().timeIntervalSince(start).readableMilliseconds)]")
    }
}
