//
//  User.swift
//  App
//
//  Created by Domagoj Pogarčić on 10/12/2018.
//

import Vapor
import FluentSQLite

final class User: Codable {
    var id: Int?
    var name: String
    var username: String
    
    init(name: String, username: String) {
        self.name = name
        self.username = username
    }
}

extension User: SQLiteModel {}

extension User: Content {}

extension User: Migration {}

extension User: Parameter {}
