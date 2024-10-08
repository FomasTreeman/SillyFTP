//
//  ServerConfigurationView.swift
//  SillyFTP
//
//  Created by Work on 09/10/2024.
//

import SwiftUI

struct ServerConfigurationView: View {
    @State private var name = ""
    @State private var host = ""
    @State private var port = 21
    @State private var username = ""
    @State private var password = ""
    @State private var isSSH = false
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Host", text: $host)
            TextField("Port", value: $port, formatter: NumberFormatter())
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            Toggle("Use SSH", isOn: $isSSH)
            
            Button("Save") {
                // Save server configuration
            }
        }
    }
}
