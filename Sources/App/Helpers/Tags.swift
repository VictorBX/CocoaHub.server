//
//  Tags.swift
//  App
//
//  Created by Pedro Carrasco on 13/04/2019.
//

import Foundation

enum TagType {
    case event
    case new
    case article
}

struct Tags {
    
    static func allowedTags(from tags: [String], of type: TagType) -> [String] {
        
        let filteredTags: [String]
        
        switch type {
        case .event:
            filteredTags = tags.filter(isEventTag)
        case .new:
            filteredTags = tags.filter(isNewTag)
        case .article:
            filteredTags = tags.filter(isArticleTag)
        }
        
        return Set(filteredTags).sorted()
    }
}

private extension Tags {
    
    enum Event {
        static let callForPapers = "callForPapers"
        static let tickets = "tickets"
    }
    
    static func isEventTag(_ tag: String) -> Bool {
        return tag == Event.callForPapers || tag == Event.tickets
    }
}

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

private extension Tags {
    
    enum Article {
        static let architecture = "architecture"
        static let business = "business"
        static let career = "career"
        static let dx = "dx"
        static let ios = "ios"
        static let language = "language"
        static let macos = "macos"
        static let testing = "testing"
        static let tipsAndTricks = "tipsAndTricks"
        static let uiux = "uiux"
        static let tvos = "tvos"
        static let watchos = "watchos"
    }
    
    static func isArticleTag(_ tag: String) -> Bool {
        return tag == Article.architecture
            || tag == Article.business
            || tag == Article.career
            || tag == Article.dx
            || tag == Article.ios
            || tag == Article.language
            || tag == Article.macos
            || tag == Article.testing
            || tag == Article.tipsAndTricks
            || tag == Article.uiux
            || tag == Article.tvos
            || tag == Article.watchos
    }
}
