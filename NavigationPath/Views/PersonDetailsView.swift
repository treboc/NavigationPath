//  Created by Marvin Lee Kobert on 15.11.23.
//
//

import SwiftUI

struct PersonDetailsView: View {
  @EnvironmentObject private var coordinator: AppCoordinator

  let person: Person

  var body: some View {
    VStack {
      Text("Name: \(person.name)")
      Text("Age: \(person.age)")

      VStack {
        Button("Pop") {
          coordinator.pop()
        }

        Button("Pop to root", action: coordinator.popToRoot)

        Button("More Details") {
          coordinator.push(.details(person: .example))
        }
      }
      .buttonStyle(.borderedProminent)
    }
  }
}

#Preview {
  PersonDetailsView(person: .example)
}
