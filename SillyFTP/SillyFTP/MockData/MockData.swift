//
//  MockData.swift
//  SillyFTP
//
//  Created by Work on 09/10/2024.
//

import Foundation

struct MockData {
    static let serverConfigurations: [ServerConfiguration] = [
        ServerConfiguration(id: UUID(), name: "Local FTP", host: "127.0.0.1", port: 21, username: "user", password: "pass", isSSH: false),
        ServerConfiguration(id: UUID(), name: "Remote SFTP", host: "example.com", port: 22, username: "admin", password: "secure", isSSH: true),
        ServerConfiguration(id: UUID(), name: "Backup Server", host: "backup.mycompany.com", port: 21, username: "backup", password: "secret", isSSH: false)
    ]
    
    static let fileSystems: [UUID: [FileItem]] = Dictionary(uniqueKeysWithValues: serverConfigurations.map { server in
        (server.id, generateMockFileSystem(for: server.name))
    })
    
    private static func generateMockFileSystem(for serverName: String) -> [FileItem] {
        let baseItems: [FileItem] = [
            FileItem(name: "Documents", modificationDate: Date().addingTimeInterval(-86400), size: 0, isDirectory: true),
            FileItem(name: "Photos", modificationDate: Date().addingTimeInterval(-172800), size: 0, isDirectory: true),
            FileItem(name: "report.pdf", modificationDate: Date().addingTimeInterval(-3600), size: 1024 * 1024, isDirectory: false),
            FileItem(name: "data.xlsx", modificationDate: Date().addingTimeInterval(-7200), size: 512 * 1024, isDirectory: false),
            FileItem(name: "script.sh", modificationDate: Date().addingTimeInterval(-300), size: 2 * 1024, isDirectory: false)
        ]
        
        // Add some server-specific files
        let serverSpecificItems: [FileItem] = [
            FileItem(name: "\(serverName.lowercased())_config.ini", modificationDate: Date(), size: 1024, isDirectory: false),
            FileItem(name: "\(serverName.lowercased())_logs", modificationDate: Date().addingTimeInterval(-43200), size: 0, isDirectory: true)
        ]
        
        return baseItems + serverSpecificItems
    }
}
