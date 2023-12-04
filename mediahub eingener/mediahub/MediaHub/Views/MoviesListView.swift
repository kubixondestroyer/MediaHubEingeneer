import SwiftUI
import FirebaseFirestoreSwift

struct MoviesListView: View {
    @StateObject var viewModel = MoviesListViewViewModel()
    @FirestoreQuery var movies: [Movie]
    
    init (userId: String) {
        self._movies = FirestoreQuery(
            collectionPath: "users/\(userId)/movies"
        )
    }
    
    var body: some View {
        NavigationView {
            if movies.count > 0 {
                List(movies) { movie in
                    NavigationLink {
                        EditMovieView(viewModel: EditMovieViewViewModel(id: movie.id, title: movie.title, director: movie.director, created: Date(timeIntervalSince1970: movie.created), isWatched: movie.isWatched))
                    } label: {
                        MoviesListItemView(title: movie.title, isWatched: movie.isWatched)
                            .swipeActions {
                                Button {
                                    viewModel.delete(id: movie.id)
                                } label: {
                                    Text("Delete")
                                }
                            }.tint(.red)
                    }
                }
                .navigationTitle("Movies")
                .toolbar {
                    Button {
                        viewModel.showingAddMovieView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $viewModel.showingAddMovieView) {
                    AddMovieView(newItemPresented: $viewModel.showingAddMovieView)
                }
            } else {
                VStack {
                    Image(systemName: "film.stack")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.blue)
                        .frame(width: 125, height: 125)
                        .padding()
                        .padding(.top, 100)
                    Text("Your movies collection is empty :(")
                    Spacer()
                }.navigationTitle("Movies")
                .toolbar {
                    Button {
                        viewModel.showingAddMovieView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $viewModel.showingAddMovieView) {
                    AddMovieView(newItemPresented: $viewModel.showingAddMovieView)
                }
            }
        }
    }
}

struct MoviesListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(userId: "hhehGNvEYgbMSssZEean65TtBmh2")
    }
}
