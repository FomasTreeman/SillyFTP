//
//  SidebarView.swift
//  SillyFTP
//
//  Created by Work on 09/10/2024.
//

import SwiftUI

struct SidebarView: View {
    @State private var servers: [ServerConfiguration] = MockData.serverConfigurations
    @Binding var selectedServer: ServerConfiguration?
    
    var body: some View {
        List(selection: $selectedServer) {
            ForEach(servers) { server in
                ServerRow(server: server)
                    .tag(server)
            }
            .onDelete(perform: deleteServer)
        }
        .listStyle(SidebarListStyle())
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: addServer) {
                    Label("Add Server", systemImage: "plus")
                }
            }
        }
    }
    
    private func deleteServer(at offsets: IndexSet) {
        servers.remove(atOffsets: offsets)
        if let selectedServer = selectedServer,
           !servers.contains(where: { $0.id == selectedServer.id }) {
            self.selectedServer = nil
        }
    }
    
    private func addServer() {
        // Placeholder for adding a new server
        let newServer = ServerConfiguration(id: UUID(), name: "New Server", host: "example.com", port: 21, username: "user", password: "pass", isSSH: false)
        servers.append(newServer)
    }
}
