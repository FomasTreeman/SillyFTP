//
//  FileItem.swift
//  SillyFTP
//
//  Created by Work on 09/10/2024.
//

import Foundation

struct FileItem: Identifiable {
    let id = UUID()
    var name: String
    var modificationDate: Date
    var size: Int64
    var isDirectory: Bool
}
