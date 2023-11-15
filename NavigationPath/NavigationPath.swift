import SwiftUI

@main
struct MyApp: App {
  @StateObject private var coordinator = AppCoordinator()

  var body: some Scene {
    WindowGroup {
      MainView()
        .environmentObject(coordinator)
    }
  }
}
