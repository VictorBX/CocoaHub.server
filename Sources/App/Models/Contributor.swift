//
//  Contributor.swift
//  App
//
//  Created by Pedro Carrasco on 12/05/2019.
//

import Vapor
import FluentMySQL
import Pagination

// MARK: - Contributor
final class Contributor {
    
    // MARK: Properties
    var id: Int?
    var name: String
    var url: String
    
    // MARK: Init
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

// MARK: - MySQLModel
extension Contributor: MySQLModel {}

// MARK: - Content
extension Contributor: Content {}

// MARK: - Migration
extension Contributor: Migration {}

// MARK: - Parameter
extension Contributor: Parameter {}

// MARK: - Paginatable
extension Contributor: Paginatable {}

// MARK: - Update
extension Contributor {
    
    @discardableResult
    func update(with contributor: Contributor) -> Contributor {
        name = contributor.name
        url = contributor.url

        return self
    }
}
