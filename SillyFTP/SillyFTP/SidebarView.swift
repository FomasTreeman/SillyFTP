import SwiftUI

struct SidebarView: View {
    @ObservedObject var serverStore = ServerStore.shared
    @State var editingServer: ServerConfiguration?
    @State private var showAddServerSheet: Bool = false
    
    var body: some View {
        Text("🌐  Servers")
            .bold()
            .font(.headline)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
        Divider()
            .padding(.horizontal)
        List(serverStore.servers, id: \.id) { server in
                ServerRow(server: server, editServer: $showAddServerSheet, editingServer: $editingServer)
                    .tag(server)
                    .onTapGesture {
                        serverStore.toggleServerSelection(server)
                    }
                    .background(server.id == serverStore.selectedServer?.id ? Color.blue : Color.clear)
                    .clipShape(Capsule(style: .circular))
                    .shadow(radius: 5)
            }
            //            .onDelete(perform: deleteServer)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showAddServerSheet = true // Set the state variable to true to show the sheet
                    }) {
                        Label("Add Server", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddServerSheet) { // Present the sheet when the variable is true
                ServerConfigurationView(show: $showAddServerSheet, editingServer: $editingServer)
            }
            .listStyle(SidebarListStyle())
    }

    private func deleteServer(at offsets: IndexSet) {
            offsets.map { serverStore.servers[$0] }.forEach { server in
                serverStore.removeServer(server) // Call the removeServer method
            }
        }
}
