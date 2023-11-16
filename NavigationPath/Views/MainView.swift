import SwiftUI

struct MainView: View {
  @EnvironmentObject private var coordinator: NavigationStore

  var body: some View {
    NavigationStack(path: $coordinator.path) {
      VStack {
        Button("Details") {
          coordinator.push(.personDetails(.example))
        }
        Button("Sheet") {
          coordinator.present(.settings)
        }
        Button("Fullscreen Cover") {
          coordinator.present(.addPerson)
        }
      }
      .buttonStyle(.borderedProminent)
      .navigationTitle("Root View")
      .navigationDestination(for: Route.self, destination: { $0 })
      .sheet(item: $coordinator.sheet, content: { $0 })
      .fullScreenCover(item: $coordinator.fullscreenCover, content: { $0 })
    }
  }
}
