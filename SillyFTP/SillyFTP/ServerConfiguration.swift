//
//  ServerConfiguration.swift
//  SillyFTP
//
//  Created by Work on 09/10/2024.
//

import Foundation

struct ServerConfiguration: Identifiable, Hashable {
    let id: UUID
    var name: String
    var host: String
    var port: Int
    var username: String
    var password: String
    var isSSH: Bool
}
