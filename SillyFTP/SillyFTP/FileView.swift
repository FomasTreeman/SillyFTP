//import SwiftUI
//
//struct FileViewer: View {
//    @ObservedObject var viewModel = FileViewModel()
//    
//    var body: some View {
//        NavigationView {
//            List(viewModel.files) { file in
//                HStack {
//                    Image(systemName: file.type == .folder ? "folder" : "doc")
//                    Text(file.name)
//                }
//                .onTapGesture {
//                    if file.type == .folder {
//                        viewModel.enterFolder(file)
//                    } else {
//                        // Handle file selection (e.g., download or view)
//                    }
//                }
//            }
//            .navigationTitle(viewModel.currentPath)
//            .toolbar {
//                ToolbarItem(placement: .navigation) {
//                    Button(action: {
//                        viewModel.goBack()
//                    }) {
//                        Image(systemName: "arrow.left")
//                    }
//                    .disabled(viewModel.currentPath == "/")
//                }
//            }
//        }
//    }
//}
