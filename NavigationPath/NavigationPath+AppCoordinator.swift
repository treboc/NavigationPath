//  Created by Marvin Lee Kobert on 15.11.23.
//
//

import SwiftUI

final class NavigationStore: ObservableObject {
  @Published var path = NavigationPath()
  @Published var sheet: SheetItem?
  @Published var fullscreenCover: FullscreenCoverItem?
}

protocol Destination: Hashable, Identifiable, View {}

extension Destination {
  var id: String { String(describing: self) }
}

enum Route: Destination {
  case personDetails(Person)
}

extension Route {
  @ViewBuilder var body: some View {
    switch self {
      case let .personDetails(person):
        PersonDetailsView(person: person)
    }
  }
}

// MARK: - Navigation
extension NavigationStore {
  @MainActor func push(_ route: Route) {
    path.append(route)
  }

  @MainActor func pop() {
    guard path.count > 0 else { return }
    path.removeLast()
  }

  @MainActor func popToRoot() {
    path.removeLast(path.count)
  }
}

// MARK: - SheetPresentation
extension NavigationStore {
  enum SheetItem: Destination {
    case settings

    @ViewBuilder var body: some View {
      switch self {
        case .settings:
          SettingsView()
      }
    }
  }

  @MainActor func present(_ sheetItem: SheetItem) {
    self.sheet = sheetItem
  }

  @MainActor func dismissSheet() {
    self.sheet = nil
  }
}

// MARK: - SheetPresentation
extension NavigationStore {
  enum FullscreenCoverItem: Destination {
    case addPerson

    @ViewBuilder var body: some View {
      switch self {
        case .addPerson:
          AddPersonView()
      }
    }
  }

  @MainActor func present(_ fullscreenCoverItem: FullscreenCoverItem) {
    self.fullscreenCover = fullscreenCoverItem
  }

  @MainActor func dismissFullscreenCover() {
    self.fullscreenCover = nil
  }
}
