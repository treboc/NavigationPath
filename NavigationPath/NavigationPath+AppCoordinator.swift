//  Created by Marvin Lee Kobert on 15.11.23.
//
//

import SwiftUI

@MainActor final class NavigationStore: ObservableObject {
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
  func push(_ route: Route) {
    path.append(route)
  }

  func pop() {
    guard path.count > 0 else { return }
    path.removeLast()
  }

  func popToRoot() {
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

  func present(_ sheetItem: SheetItem) {
    self.sheet = sheetItem
  }

  func dismissSheet() {
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

  func present(_ fullscreenCoverItem: FullscreenCoverItem) {
    self.fullscreenCover = fullscreenCoverItem
  }

  func dismissFullscreenCover() {
    self.fullscreenCover = nil
  }
}
