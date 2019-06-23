//
//  Collection+Second.swift
//  App
//
//  Created by Pedro Carrasco on 23/06/2019.
//

import Foundation

extension Array where Element == String {
    
    var second: Element? {
        return count >= 2 ? self[1] : nil
    }
}
