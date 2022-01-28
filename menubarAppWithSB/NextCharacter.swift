//
//  NextCharacter.swift
//  menubarAppWithSB
//
//  Created by Murat Can KOÇ on 29.01.2022.
//

import Foundation

struct NextCharacter {
    // create a dictionary that will store our character mapping
    private static var key = [Character: Character]()

    // create arrays of all uppercase and lowercase letters
    private static let uppercase = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    private static let lowercase = Array("abcdefghijklmnopqrstuvwxyz")

    static func string(_ string: String) -> String {
        // if this is the first time the method is being called, calculate the NextCharacter key dictionary
        if NextCharacter.key.isEmpty {
            for i in 0 ..< 26 {
                NextCharacter.key[NextCharacter.uppercase[i]] = NextCharacter.uppercase[(i + 1) % 26]
                NextCharacter.key[NextCharacter.lowercase[i]] = NextCharacter.lowercase[(i + 1) % 26]
            }
        }

        // now return the transformed string
        let transformed = string.map { NextCharacter.key[$0] ?? $0 }
        return String(transformed)
    }
}

extension String {
    func nextCharacter() -> String {
        return NextCharacter.string(self)
    }
}
