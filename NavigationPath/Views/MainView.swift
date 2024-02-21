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
        //    .background {
        //        ZStack {
        //            Color.clear
        //                .sheet(item: $navigationStore.sheets, content: { $0 })
        //            Color.clear
        //                .sheet(item: $navigationStore.sheet2, content: { $0 })
        //        }
        //    }
        //    .sheet(item: $navigationStore.sheet) { $0 }
        .fullScreenCover(item: $navigationStore.fullscreenCover, content: { $0 })
        .modifier(Sheetable(sheets: $navigationStore.sheets, index: 0))
    }
}


struct Sheetable: ViewModifier {
    @Binding var sheets: [NavigationStore.SheetItem]
    let index: Int?

    @ViewBuilder func body(content: Content) -> some View {
        if !sheets.isEmpty, let item = sheets[safeIndex: index ?? 0] {
            content
                .sheet(item: Binding<NavigationStore.SheetItem?>(get: {
                    return item
                }, set: { item in
                    if let item = item {
                        sheets.insert(item, at: 0)
                    }
                })) { item in
                    item.body
                        .modifier(Sheetable(sheets: $sheets, index: (index ?? 0) + 1 ))
                }
        } else {
            content
        }
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
