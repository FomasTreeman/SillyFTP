//
//  FileRow.swift
//  SillyFTP
//
//  Created by Work on 09/10/2024.
//

import SwiftUI
import Foundation

struct FSItem: Identifiable {
    let id = UUID()
    var name: String
    var modificationDate: Date
    var size: Int64
    var isDirectory: Bool
    var children: [FSItem]? = []
}

struct FileRow: View {
    let item: FSItem
    let level: Int
    
    var body: some View {
        HStack {
            Text("")
                .frame(width: 20 * CGFloat(level))
            Image(systemName: item.isDirectory ? "folder" : "doc")
            Text(item.name)
            Spacer()
            Text(item.modificationDate, style: .date)
            Text(ByteCountFormatter().string(fromByteCount: item.size))
        }
        .contextMenu {
            Button("Download") {
                // Implement download action
            }
            if !item.isDirectory {
                Button("Gzip") {
                    // Implement gzip action
                }
            }
        }
    }
}
