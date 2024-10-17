import SwiftUI
import Combine

struct ServerRow: View {
    let server: ServerConfiguration
    @Binding var editServer: Bool
    @Binding var editingServer: ServerConfiguration?
    @ObservedObject var serverStore = ServerStore.shared
    
    var body: some View {
        Text(server.name)
            .contextMenu {
                Button("Edit") {
                    // Show edit server modal
                    editServer.toggle()
                    editingServer = server
                }
                Button("Delete", role: .destructive) {
                    // Delete server
                    serverStore.removeServer(server)
                }
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button("Delete", role: .destructive) {
                    serverStore.removeServer(server)
                }
            }
            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                Button("Edit") {
                    editServer.toggle()
                    editingServer = server
                }.tint(.yellow)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
    }
}
