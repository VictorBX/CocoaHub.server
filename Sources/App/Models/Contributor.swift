//
//  Contributor.swift
//  App
//
//  Created by Pedro Carrasco on 14/04/2019.
//

import Vapor
import FluentMySQL

final class Contributor: MySQLModel {
    var id: Int?
    let name: String
    let uri: String
    
    init(name: String, uri: String) {
        self.name = name
        self.uri = uri
    }
}

extension Contributor: Content {}

extension Contributor: Migration {}

