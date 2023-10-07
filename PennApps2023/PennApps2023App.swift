import SwiftUI
import Firebase

@main
struct PennApps2023App: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        FirebaseApp.configure()
    }
}

