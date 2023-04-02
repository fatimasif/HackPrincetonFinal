//
//  User.swift
//  HackPrincetonFinal
//
//  Created by Owen Yang on 4/1/23.
//

import Foundation

public struct User: Codable {
    let email: String
    let fname: String
    let lname: String
    let preferences: [String]
}
