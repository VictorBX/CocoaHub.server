//
//  Tags.swift
//  App
//
//  Created by Pedro Carrasco on 13/04/2019.
//

import Foundation

// MARK: - TagType
enum TagType {
    case event
    case new
    case article
}

// MARK: - Tags
struct Tags {
    
    static func allowedTags(from tags: [String], of type: TagType) -> [String] {
        switch type {
        case .event:
            return tags.filter(isEventTag)
        case .new:
            return tags.filter(isNewTag)
        case .article:
            return tags.filter(isArticleTag)
        }
    }
}

// MARK: - Event Tags
private extension Tags {
    
    enum Event {
        static let callForPapers = "callForPapers"
        static let tickets = "tickets"
    }
    
    static func isEventTag(_ tag: String) -> Bool {
        return tag == Event.callForPapers || tag == Event.tickets
    }
}

// MARK: - New Tags
private extension Tags {
    
    enum New {
        static let apple = "apple"
        static let evolution = "evolution"
        static let community = "community"
    }
    
    static func isNewTag(_ tag: String) -> Bool {
        return tag == New.apple || tag == New.community || tag == New.apple
    }
}

// MARK: - Article Tags
private extension Tags {
    
    enum Article {
        static let architecture = "architecture"
        static let serverSide = "serverSide"
        static let business = "business"
        static let career = "career"
        static let design = "design"
        static let dx = "dx"
        static let ios = "ios"
        static let language = "language"
        static let macos = "macos"
        static let testing = "testing"
        static let tipsAndTricks = "tipsAndTricks"
        static let ui = "ui"
        static let tvos = "tvos"
        static let watchos = "watchos"
    }
    
    static func isArticleTag(_ tag: String) -> Bool {
        return tag == Article.architecture
            || tag == Article.serverSide
            || tag == Article.business
            || tag == Article.career
            || tag == Article.design
            || tag == Article.dx
            || tag == Article.ios
            || tag == Article.language
            || tag == Article.macos
            || tag == Article.testing
            || tag == Article.tipsAndTricks
            || tag == Article.ui
            || tag == Article.tvos
            || tag == Article.watchos
    }
}
