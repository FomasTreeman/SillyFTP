import SwiftUI
import Foundation

struct ServerConfiguration: Identifiable, Hashable {
    let id: UUID
    var name: String
    var host: String
    var port: Int
    var username: String
    var password: String
    var isSSH: Bool
    var isSelected: Bool?
}

struct ServerConfigurationView: View {
    @Binding var show: Bool
    @Binding var editingServer: ServerConfiguration?
    
    @ObservedObject var serverStore = ServerStore.shared
    
    @State private var name = ""
    @State private var host = ""
    @State private var port: Int = 21
    @State private var username = ""
    @State private var password = ""
    @State private var isSSH = false
    
    // Error messages for each field
    @State private var nameError: String?
    @State private var hostError: String?
    @State private var portError: String?
    @State private var usernameError: String?
    @State private var passwordError: String?

    var body: some View {
        VStack(spacing: 20) {
            Text("Server Configuration")
                .font(.headline)
                .padding()

            // Name Field
            VStack(alignment: .leading) {
                Text("Name")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                TextField("Enter server name", text: $name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .cornerRadius(8)
                // Display name error
                if let nameError = nameError {
                    Text(nameError)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }

            // Host Field
            VStack(alignment: .leading) {
                Text("Host")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                TextField("Enter server host", text: $host)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .cornerRadius(8)
                // Display host error
                if let hostError = hostError {
                    Text(hostError)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }

            // Port Field
            VStack(alignment: .leading) {
                Text("Port")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                TextField("Enter server port", value: $port, formatter: NumberFormatter())
                    .textFieldStyle(DefaultTextFieldStyle())
                    .cornerRadius(8)
                // Display port error
                if let portError = portError {
                    Text(portError)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }

            // Username Field
            VStack(alignment: .leading) {
                Text("Username")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                TextField("Enter username", text: $username)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .cornerRadius(8)
                // Display username error
                if let usernameError = usernameError {
                    Text(usernameError)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }

            // Password Field
            VStack(alignment: .leading) {
                Text("Password")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                SecureField("Enter password", text: $password)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .cornerRadius(8)
                // Display password error
                if let passwordError = passwordError {
                    Text(passwordError)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }

            // SSH Toggle
            Toggle("Use SSH", isOn: $isSSH)
                .padding()
                .toggleStyle(SwitchToggleStyle(tint: .blue))

            // Save Button
            Button(action: saveServerConfiguration) {
                Text("Save")
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
        }
        .padding()
        .navigationTitle(editingServer == nil ? "Add Server" : "Edit Server")
        .onAppear {
            // Set the values of the state variables if editingServer is not nil
            if let server = editingServer {
                name = server.name
                host = server.host
                port = server.port
                username = server.username
                password = server.password
                isSSH = server.isSSH
            }
        }
    }

    private func saveServerConfiguration() {
        // Reset error messages before validation
        nameError = nil
        hostError = nil
        portError = nil
        usernameError = nil
        passwordError = nil
        
        if validateInput() {
            if let selectedServer = editingServer {
                serverStore.updateServer(ServerConfiguration(id: selectedServer.id, name: name, host: host, port: port, username: username, password: password, isSSH: isSSH))
                editingServer = nil // Clear the editing server after saving
            } else {
                serverStore.addServer(ServerConfiguration(id: UUID(), name: name, host: host, port: port, username: username, password: password, isSSH: isSSH))
            }
            print("Server configuration saved successfully")
            show.toggle() // Dismiss the view
        } else {
            print("Error: Some fields are invalid")
        }
    }

    private func validateInput() -> Bool {
        var isValid = true
        
        if name.isEmpty {
            nameError = "Name cannot be empty"
            isValid = false
        }
        if host.isEmpty {
            hostError = "Host cannot be empty"
            isValid = false
        }
        if port < 0 || port > 65535 {
            portError = "Port number is out of range"
            isValid = false
        }
        if username.isEmpty {
            usernameError = "Username cannot be empty"
            isValid = false
        }
        if password.isEmpty {
            passwordError = "Password cannot be empty"
            isValid = false
        }
        
        return isValid
    }
}
