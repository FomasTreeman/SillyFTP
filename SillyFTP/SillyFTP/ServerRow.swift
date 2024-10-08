//
//  ServerRow.swift
//  SillyFTP
//
//  Created by Work on 09/10/2024.
//

import SwiftUI

struct ServerRow: View {
    let server: ServerConfiguration
    
    var body: some View {
        Text(server.name)
            .contextMenu {
                Button("Edit") {
                    // Show edit server modal
                }
                Button("Delete", role: .destructive) {
                    // Delete server
                }
            }
    }
}
