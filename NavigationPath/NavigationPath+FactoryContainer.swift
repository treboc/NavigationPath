//  Created by Marvin Lee Kobert on 16.11.23.
//  
//

import Factory
import Foundation

extension Container {
  var navigationStore: Factory<NavigationStore> {
    self { NavigationStore() }
      .singleton
  }
}
