//
//  TimeInterval+Readable.swift
//  App
//
//  Created by Pedro Carrasco on 18/04/2019.
//

import Foundation

// MARK: - Readable
extension TimeInterval {
    
    var readableMilliseconds: String {
        let string = (self * 1000).description
        guard let dotIndex = string.index(of: ".") else { return "" }
        let endIndex = string.index(dotIndex, offsetBy: 2)
        let trimmed = string[string.startIndex..<endIndex]
        return "\(trimmed) ms"
    }
}
