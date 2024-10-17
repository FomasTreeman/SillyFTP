import SwiftUI

struct MainContentView: View {
    @State private var items: [FSItem] = []
    @State private var sortOrder: SortOrder = .name
    @State private var sortAscending: Bool = true
    @State private var selectedRow: UUID?
    @ObservedObject var serverStore = ServerStore.shared
    
    enum SortOrder {
        case name
        case modificationDate
        case size
    }
    
    var body: some View {
        if let server = serverStore.selectedServer {
            VStack {
                HeaderView(sortOrder: $sortOrder, sortAscending: $sortAscending)
                List {
                    ForEach(MockData.fileSystems[server.id]!.sorted { item1, item2 in
                        switch sortOrder {
                        case .name:
                            return sortAscending ? item1.name < item2.name : item1.name > item2.name
                        case .modificationDate:
                            return sortAscending ? item1.modificationDate < item2.modificationDate : item1.modificationDate > item2.modificationDate
                        case .size:
                            return sortAscending ? item1.size < item2.size : item1.size > item2.size
                        }
                    }) { item in
                        RowView(item: item)
                            .environmentObject(SelectedRow(selectedRow: selectedRow ?? nil))
                            .contentShape(Rectangle())
                    }
                }
            }
        } else {
            Text("Select a server to view files")
        }
    }
}

struct HeaderView: View {
    @Binding var sortOrder: MainContentView.SortOrder
    @Binding var sortAscending: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                sortOrder = .name
                sortAscending.toggle()
            }) {
                Text("Name")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer(minLength: 20) // Add a spacer to separate the fields
            Button(action: {
                sortOrder = .modificationDate
                sortAscending.toggle()
            }) {
                Text("Modification Date")
                    .frame(width: 120, alignment: .leading) // Set a fixed width for the date field
            }
            Spacer(minLength: 20) // Add a spacer to separate the fields
            Button(action: {
                sortOrder = .size
                sortAscending.toggle()
            }) {
                Text("Size")
                    .frame(width: 80, alignment: .leading) // Set a fixed width for the size field
            }
        }
        .padding(.top, 10)
        .padding(.horizontal, 10)
        
    }
}


struct RowView: View {
    let item: FSItem
    
    var body: some View {
        if let children = item.children, !children.isEmpty {
            DisclosureGroup(content: {
                ForEach(children) { child in
                    RowView(item: child)
                }
            }) {
                FileView(item: item)
            }
        } else {
            FileView(item: item)
        }
    }
}

struct FileView: View {
    let item: FSItem
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    @EnvironmentObject var SelectedRow: SelectedRow
    let id: UUID = UUID.init()
    
    var body: some View {
        HStack {
            Text(item.name)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer(minLength: 20) // Add a spacer to separate the fields
            Text(item.modificationDate, formatter: dateFormatter)
                .frame(width: 120, alignment: .leading) // Set a fixed width for the date field
            Spacer(minLength: 20) // Add a spacer to separate the fields
            Text(ByteCountFormatter().string(fromByteCount: item.size))
                .frame(width: 80, alignment: .trailing) // Set a fixed width for the size field
        }
        .background(id == SelectedRow.selectedRow ? Color.blue : Color.clear)
        .onTapGesture {
            SelectedRow.selectedRow = id
        }
    }
}


class SelectedRow: ObservableObject {
    @Published var selectedRow: UUID?
    
    init(selectedRow: UUID? = nil) {
        self.selectedRow = selectedRow
    }
}
