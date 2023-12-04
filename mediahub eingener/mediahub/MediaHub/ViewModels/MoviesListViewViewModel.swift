import Foundation
import FirebaseFirestore
import FirebaseAuth

class MoviesListViewViewModel: ObservableObject {
    @Published var showingAddMovieView: Bool = false
    
    init () {
        
    }
    
    func delete(id: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("movies")
            .document(id)
            .delete()
    }
}
