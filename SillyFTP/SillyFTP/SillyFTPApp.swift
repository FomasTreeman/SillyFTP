import SwiftUI

@main
struct SillyFTPApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            SidebarView()
            MainContentView()
        }
    }
}


#Preview {
    ContentView()
}
