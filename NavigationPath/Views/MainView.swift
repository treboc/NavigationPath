import SwiftUI

struct MainView: View {
  @EnvironmentObject private var coordinator: AppCoordinator

  var body: some View {
    NavigationStack(path: $coordinator.path) {
      VStack {
        Button("Details") {
          coordinator.push(.details(person: .example))
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
      .navigationDestination(for: AppCoordinator.Route.self, destination: { $0 })
      .sheet(item: $coordinator.sheet, content: { $0 })
      .fullScreenCover(item: $coordinator.fullscreenCover, content: { $0 })
    }
  }
}
