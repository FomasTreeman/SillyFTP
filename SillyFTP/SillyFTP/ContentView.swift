//
//  ContentView.swift
//  SillyFTP
//
//  Created by Work on 09/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedServer: ServerConfiguration?
    
    var body: some View {
        NavigationView {
            SidebarView(selectedServer: $selectedServer)
            MainContentView(selectedServer: $selectedServer)
        }
    }
}
