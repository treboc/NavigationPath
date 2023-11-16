//  Created by Marvin Lee Kobert on 15.11.23.
//
//

import SwiftUI

struct PersonDetailsView: View {
  @EnvironmentObject private var coordinator: NavigationStore

  let person: Person

  var body: some View {
    VStack {
      Text("Name: \(person.name)")
      Text("Age: \(person.age)")

      VStack {
        Button("Pop") {
          coordinator.pop()
        }

        Button("Pop to root") { coordinator.popToRoot() }

        Button("More Details") {
          coordinator.push(.personDetails(.example))
        }
      }
      .buttonStyle(.borderedProminent)
    }
  }
}

#Preview {
  PersonDetailsView(person: .example)
}
