//  Created by Marvin Lee Kobert on 15.11.23.
//
//

import SwiftUI

struct AddPersonView: View {
  @EnvironmentObject private var coordinator: AppCoordinator
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    NavigationStack {
      Form {
        TextField("Name", text: .constant(""))

        Section {
          Button("Save") {}
          // Both options are viable here!
          Button("Cancel", action: coordinator.dismissFullscreenCover)
          Button("Cancel", action: dismiss.callAsFunction)
        }
      }
      .navigationTitle("Add Person")
    }
  }
}

#Preview {
  AddPersonView()
}
