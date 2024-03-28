//
//  WatchHomeView.swift
//
//
//  Created by Md. Rayhan Nabi on 22/3/24.
//

import Common
import Domain
import OTPGenerator
import SwiftUI

public struct WatchHomeView: View {
  @Bindable var store: StoreOf<WatchHome>

  public init(store: StoreOf<WatchHome>) {
    self.store = store
  }

  public var body: some View {
    NavigationSplitView {
      List(selection: $store.selectedEntry) {
        ForEach(store.filteredEntries) { entry in
          WatchHomeEntryView(entry: entry)
            .background {
              NavigationLink(value: entry) {}
            }
        }
      }
      .searchable(text: $store.searchText.sending(\.searchUpdated), placement: .toolbar)
      .listStyle(.carousel)
    } detail: {
      TabView(selection: $store.selectedEntry) {
        ForEach(store.entries) { entry in
          OTPGeneratorWatchView(
            store: .init(
              initialState: OTPGenerator.State(entry: entry),
              reducer: OTPGenerator.init
            )
          )
          .tag(Optional(entry))
        }
      }
      .tabViewStyle(.verticalPage)
    }
  }
}

#if DEBUG
#Preview {
  WatchHomeView(
    store: .init(initialState: WatchHome.State(entries: Entry.mocks), reducer: WatchHome.init)
  )
}
#endif
