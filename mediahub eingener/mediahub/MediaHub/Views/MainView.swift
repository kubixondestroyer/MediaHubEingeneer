//import SwiftUI
//
//struct MainView: View {
//    @StateObject var viewModel = MainViewViewModel()
//
//    var body: some View {
//        NavigationView {
//            if (viewModel.isSignedIn && !viewModel.currentUserId.isEmpty) {
//                accountView
//            } else {
//                LoginView()
//            }
//        }
//    }
//
//    @ViewBuilder
//    var accountView: some View {
//        TabView {
//            MoviesListView(userId: viewModel.currentUserId)
//                .tabItem {
//                    Label("Movies", systemImage: "film")
//                }
//            ProfileView()
//                .tabItem {
//                    Label("Profile", systemImage: "person.circle")
//                }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//            .environmentObject(MainViewViewModel())
//    }
//}


import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.isSignedIn && !viewModel.currentUserId.isEmpty {
                accountView
            } else {
                LoginView()
            }
        }
    }
    
    @ViewBuilder
    var accountView: some View {
        TabView {
            MoviesListView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("Movies", systemImage: "film")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(MainViewViewModel())
            .previewDevice("iPhone 14") // Dodane, aby uniknąć problemów z NavigationView w podglądzie
    }
}
