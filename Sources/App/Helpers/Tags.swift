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
            filteredTags = tags.filter(Tags.isEventTag)
        default:
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
        return tag == Tags.Event.callForPapers || tag == Tags.Event.tickets
    }
}
