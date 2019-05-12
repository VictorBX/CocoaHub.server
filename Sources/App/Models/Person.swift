//
//  Contributor.swift
//  App
//
//  Created by Pedro Carrasco on 14/04/2019.
//

import Vapor
import FluentMySQL

// MARK: - Person
final class Person {
    
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
extension Person: Content {}

// MARK: - Comparable
extension Person: Comparable {
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}

// MARK: - Comparable
extension Person: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(uri)
    }
}
