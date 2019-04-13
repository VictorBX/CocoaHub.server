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
            filteredTags = []
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
