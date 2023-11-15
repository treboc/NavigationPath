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
      .navigationDestination(for: AppCoordinator.Route.self) { route in
        coordinator.view(for: route)
      }
      .sheet(item: $coordinator.sheet) { item in
        coordinator.view(for: item)
      }
      .fullScreenCover(item: $coordinator.fullscreenCover) { item in
        coordinator.view(for: item)
      }
    }
  }
}
