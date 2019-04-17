//
//  Contributor.swift
//  App
//
//  Created by Pedro Carrasco on 14/04/2019.
//

import Vapor
import FluentMySQL

// MARK: - Contributor
final class Contributor {
    
    // MARK: Properties
    let name: String
    let uri: String
    
    // MARK: Init
    init(name: String, uri: String) {
        self.name = name
        self.uri = uri
    }
}

// MARK: - Content
extension Contributor: Content {}
