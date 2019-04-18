//
//  SecretMiddleware.swift
//  App
//
//  Created by Pedro Carrasco on 18/04/2019.
//

import Vapor

// MARK: - SecretMiddleware
final class SecretMiddleware {
    
    // MARK: Constant
    private enum Constant {
        static let nonProductionSecret = "_SECRET_"
        static let incorrectHeaderReason = "Incorrect X-CocoaHub-Secret header."
        static let noSecretReason = "No $SECRET set on environment."
    }
    
    // MARK: Private Properties
    private let secret: String
    
    // MARK: Init
    init(with secret: String) {
        self.secret = secret
    }
}

// MARK: - Middleware
extension SecretMiddleware: Middleware {
    
    func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {
        guard request.http.headers.firstValue(name: .secret) == secret else {
            throw Abort( .unauthorized, reason: Constant.incorrectHeaderReason)
        }
        
        return try next.respond(to: request)
    }
}

// MARK: - ServiceType
extension SecretMiddleware: ServiceType {
    
    static func makeService(for container: Container) throws -> SecretMiddleware {
        switch container.environment {
        case .production:
            guard let secret = Environment.secret else {
                throw Abort(.internalServerError, reason: Constant.noSecretReason)
            }
            return SecretMiddleware(with: secret)
            
        default:
            return SecretMiddleware(with: Constant.nonProductionSecret)
        }
    }
}
