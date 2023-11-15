//  Created by Marvin Lee Kobert on 15.11.23.
//
//

import SwiftUI

final class AppCoordinator: ObservableObject {
  @Published var path = NavigationPath()
  @Published var sheet: SheetItem?
  @Published var fullscreenCover: FullscreenCoverItem?

  @ViewBuilder func view(for destination: some Destination) -> some View {
    if let route = destination as? Route {
      switch route {
        case .details(let person):
          PersonDetailsView(person: person)
      }
    } else if let item = destination as? SheetItem {
      switch item {
        case .settings:
          SettingsView()
      }
    } else if let item = destination as? FullscreenCoverItem {
      switch item {
        case .addPerson:
          AddPersonView()
      }
    }
  }
}

protocol Destination: Hashable, Identifiable {}

extension Destination {
  var id: String { String(describing: self) }
}

// MARK: - Navigation
extension AppCoordinator {
  enum Route: Destination {
    case details(person: Person)
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
  }

  func present(_ fullscreenCoverItem: FullscreenCoverItem) {
    self.fullscreenCover = fullscreenCoverItem
  }

  func dismissFullscreenCover() {
    self.fullscreenCover = nil
  }
}
