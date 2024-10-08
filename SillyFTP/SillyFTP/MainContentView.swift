//
//  MainContentView.swift
//  SillyFTP
//
//  Created by Work on 09/10/2024.
//

import SwiftUI

struct MainContentView: View {
    @Binding var selectedServer: ServerConfiguration?
    @State private var items: [FileItem] = []
    
    var body: some View {
        Group {
            if let server = selectedServer {
                List(MockData.fileSystems[server.id] ?? []) { item in
                    FileRow(item: item)
                }
            } else {
                Text("Select a server to view files")
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle(selectedServer?.name ?? "No Server Selected")
        .listStyle(PlainListStyle())
    }
}
