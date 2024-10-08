//import Foundation
//
//enum FileType {
//    case file
//    case folder
//}
//
//struct FileItem: Identifiable {
//    let id = UUID()
//    let name: String
//    let type: FileType
//}
//
//class FileViewModel: ObservableObject {
//    @Published var currentPath: String = "/"
//    @Published var files: [FileItem] = []
//    private var pathStack: [String] = []
//    
//    init() {
//        // Load initial files
//        loadFiles(at: currentPath)
//    }
//    
//    func loadFiles(at path: String) {
//        // This is where you would call your FTP/SFTP library to get the files
//        // For now, we'll use dummy data
//        self.files = [
//            FileItem(name: "Folder1", type: .folder),
//            FileItem(name: "File1.txt", type: .file),
//            FileItem(name: "File2.jpg", type: .file)
//        ]
//    }
//    
//    func enterFolder(_ folder: FileItem) {
//        guard folder.type == .folder else { return }
//        pathStack.append(currentPath)
//        currentPath = "\(currentPath)/\(folder.name)"
//        loadFiles(at: currentPath)
//    }
//    
//    func goBack() {
//        guard !pathStack.isEmpty else { return }
//        currentPath = pathStack.removeLast()
//        loadFiles(at: currentPath)
//    }
//}
