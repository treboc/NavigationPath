//  Created by Marvin Lee Kobert on 15.11.23.
//
//

import Factory
import SwiftUI

struct PersonDetailsView: View {
    @InjectedObject(\.navigationStore) private var navigationStore

    let person: Person

    var body: some View {
        VStack {
            Text("Name: \(person.name)")
            Text("Age: \(person.age)")

            VStack {
                Button("Pop") {
                    navigationStore.pop()
                }

                Button("Pop to root") { navigationStore.popToRoot() }

                Button("More Details") {
                    navigationStore.push(.personDetails(.example))
                }

                Button("Sheet") {
                    navigationStore.present(.person)
                }

                Button("Fullscreen Cover") {
                    navigationStore.present(.addPerson)
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    PersonDetailsView(person: .example)
}
