//
//  ROT13.swift
//  menubarAppWithSB
//
//  Created by Murat Can KOÇ on 29.01.2022.
//

import Foundation

struct ROT13 {
    // create a dictionary that will store our character mapping
    private static var key = [Character: Character]()

    // create arrays of all uppercase and lowercase letters
    private static let uppercase = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    private static let lowercase = Array("abcdefghijklmnopqrstuvwxyz")

    static func string(_ string: String) -> String {
        // if this is the first time the method is being called, calculate the ROT13 key dictionary
        if ROT13.key.isEmpty {
            for i in 0 ..< 26 {
                ROT13.key[ROT13.uppercase[i]] = ROT13.uppercase[(i + 13) % 26]
                ROT13.key[ROT13.lowercase[i]] = ROT13.lowercase[(i + 13) % 26]
            }
        }

        // now return the transformed string
        let transformed = string.map { ROT13.key[$0] ?? $0 }
        return String(transformed)
    }
}

extension String {
    func rot13() -> String {
        return ROT13.string(self)
    }
}
