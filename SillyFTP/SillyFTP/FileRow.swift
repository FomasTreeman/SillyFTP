//
//  FileRow.swift
//  SillyFTP
//
//  Created by Work on 09/10/2024.
//

import SwiftUI

struct FileRow: View {
    let item: FileItem
    
    var body: some View {
        HStack {
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
