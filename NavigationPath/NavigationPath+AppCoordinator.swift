//  Created by Marvin Lee Kobert on 15.11.23.
//
//

import SwiftUI

final class AppCoordinator: ObservableObject {
  @Published var path = NavigationPath()
  @Published var sheet: SheetItem?
  @Published var fullscreenCover: FullscreenCoverItem?
}

protocol Destination: Hashable, Identifiable, View {}

extension Destination {
  var id: String { String(describing: self) }
}

// MARK: - Navigation
extension AppCoordinator {
  enum Route: Destination, View {
    case details(person: Person)

    @ViewBuilder var body: some View {
      switch self {
        case .details(let person):
          PersonDetailsView(person: person)
      }
    }
  }

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
extension AppCoordinator {
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
extension AppCoordinator {
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
