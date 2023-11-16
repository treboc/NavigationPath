import Factory
import SwiftUI

struct MainView: View {
  @InjectedObject(\.navigationStore) private var navigationStore

  var body: some View {
    NavigationStack(path: $navigationStore.path) {
      VStack {
        Button("Details") {
          navigationStore.push(.personDetails(.example))
        }
        Button("Sheet") {
          navigationStore.present(.settings)
        }
        Button("Fullscreen Cover") {
          navigationStore.present(.addPerson)
        }
      }
      .buttonStyle(.borderedProminent)
      .navigationTitle("Root View")
      .navigationDestination(for: Route.self, destination: { $0 })
      .sheet(item: $navigationStore.sheet, content: { $0 })
      .fullScreenCover(item: $navigationStore.fullscreenCover, content: { $0 })
    }
  }
}
