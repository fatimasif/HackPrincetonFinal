//
//  User.swift
//  HackPrincetonFinal
//
//  Created by Owen Yang on 4/1/23.
//

import Foundation

public struct User: Codable {
    let email: String
    let phone: String
    let firstname: String
    let lastname: String
    let preferences: [String]
}
