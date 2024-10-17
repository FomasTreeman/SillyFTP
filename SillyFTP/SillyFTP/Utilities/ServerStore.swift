import SwiftUI

class ServerStore: ObservableObject {
    static let shared = ServerStore()
    @Published var servers: [ServerConfiguration] = MockData.serverConfigurations
    @Published var selectedServer: ServerConfiguration?
    
    func addServer(_ server: ServerConfiguration) {
        servers.append(server)
    }
    
    func removeServer(_ server: ServerConfiguration) {
        // Directly compare UUIDs instead of converting to strings
        servers.removeAll(where: { $0.id == server.id })
//        servers = [...servers]
    }
    
    func getServer(_ id: UUID) -> ServerConfiguration? {
        servers.first(where: { $0.id == id })
    }
    
    func updateServer(_ server: ServerConfiguration) {
//        update existing server using the id
        let index = servers.firstIndex(where: { $0.id == server.id })
        if (index != nil) {
            servers[index!] = server
        }
    }
    
    func toggleServerSelection(_ server: ServerConfiguration) {
        selectedServer = server
    }
}
