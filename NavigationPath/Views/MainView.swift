import Factory
import SwiftUI

struct MainView: View {
    @InjectedObject(\.navigationStore) private var navigationStore

    var body: some View {
        NavigationStack(path: $navigationStore.path) {
            VStack {
                Button("Details") {
                    navigationStore.push(.personDetails(.example))
                }
                Button("Sheet") {
                    navigationStore.present(.addPerson)
                }
                Button("Fullscreen Cover") {
                    navigationStore.present(.addPerson)
                }
            }
            .buttonStyle(.borderedProminent)
            .navigationTitle("Root View")
            .navigationDestination(for: Route.self, destination: { $0 })
        }
        .fullScreenCover(item: $navigationStore.fullscreenCover, content: { $0 })
        .sheets(items: $navigationStore.sheets, index: 0)
    }
}


struct Sheetable: ViewModifier {
    @Binding var items: [NavigationStore.SheetItem]
    let index: Int?

    @ViewBuilder func body(content: Content) -> some View {
        if !items.isEmpty, let item = items[safeIndex: index ?? 0] {
            content
                .sheet(item: Binding<NavigationStore.SheetItem?>(get: {
                    return item
                }, set: { item in
                    if let item = item {
                        items.insert(item, at: 0)
                    }
                })) { item in
                    item.body
                        .modifier(Sheetable(items: $items, index: (index ?? 0) + 1 ))
                }
        } else {
            content
        }
    }
}

extension View {
    func sheets(items: Binding<[NavigationStore.SheetItem]>, index: Int?) -> some View {
        modifier(Sheetable(items: items, index: index))
    }
}

public extension Array {
  subscript(safeIndex index: Int) -> Element? {
    guard index >= 0, index < endIndex else {
      return nil
    }

    return self[index]
  }
}
