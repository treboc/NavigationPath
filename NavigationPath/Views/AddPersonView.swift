//  Created by Marvin Lee Kobert on 15.11.23.
//
//

import Factory
import SwiftUI

struct AddPersonView: View {
  @InjectedObject(\.navigationStore) private var navigationStore
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    NavigationStack {
      Form {
        TextField("Name", text: .constant(""))

        Section {
          Button("Save") {}
          // Both options are viable here!
          Button("Cancel (via coordinator)") { navigationStore.dismissFullscreenCover() }
          Button("Cancel (via dismiss)", action: dismiss.callAsFunction)
        }
      }
      .navigationTitle("Add Person")
    }
  }
}

#Preview {
  AddPersonView()
}
