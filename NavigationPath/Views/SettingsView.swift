//  Created by Marvin Lee Kobert on 15.11.23.
//
//

import SwiftUI

struct SettingsView: View {
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    NavigationStack {
      Text("Yo, settings here.")
        .navigationTitle("Settings")
        .toolbar {
          Button("Close", action: dismiss.callAsFunction)
        }
    }
  }
}

#Preview {
  SettingsView()
}
