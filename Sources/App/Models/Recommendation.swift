//
//  Recommendation.swift
//  App
//
//  Created by Pedro Carrasco on 14/04/2019.
//

import Vapor
import FluentMySQL

// MARK: - Recommendation
final class Recommendation {
    
    // MARK: Properties
    let logo: String
    let name: String
    let description: String
    let url: String
    
    // MARK: Init
    init(logo: String, name: String, description: String, url: String) {
        self.logo = logo
        self.name = name
        self.description = description
        self.url = url
    }
}

// MARK: - Content
extension Recommendation: Content {}
