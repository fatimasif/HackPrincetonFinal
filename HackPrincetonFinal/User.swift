//
//  User.swift
//  HackPrincetonFinal
//
//  Created by Owen Yang on 4/1/23.
//

import Foundation

public struct User: Codable {
    let username: String
    let name: String
    let preferences: [String]
}
