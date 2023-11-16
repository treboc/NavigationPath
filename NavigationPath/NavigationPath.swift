import SwiftUI

@main
struct MyApp: App {
  @StateObject private var coordinator = NavigationStore()

  var body: some Scene {
    WindowGroup {
      MainView()
        .environmentObject(coordinator)
    }
  }
}
