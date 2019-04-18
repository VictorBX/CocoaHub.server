//
//  TimeInterval+Readable.swift
//  App
//
//  Created by Pedro Carrasco on 18/04/2019.
//

import Foundation

extension TimeInterval {
    
    /// Converts the time internal to readable milliseconds format, i.e., "3.4ms"
    var readableMilliseconds: String {
        let string = (self * 1000).description
        // include one decimal point after the zero
        guard let dotIndex = string.index(of: ".") else { return "" }
        let endIndex = string.index(dotIndex, offsetBy: 2)
        let trimmed = string[string.startIndex..<endIndex]
        return "\(trimmed) ms"
    }
}
