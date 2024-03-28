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
      List(selection: $store.selectedEntry.sending(\.entrySelected)) {
        ForEach(store.filteredEntries) { entry in
          WatchHomeEntryView(entry: entry)
            .background {
              NavigationLink(value: entry) {}
            }
        }
      }
      .searchable(text: $store.searchText.sending(\.searchUpdated), placement: .toolbar)
      .listStyle(.carousel)
      .onAppear {
        store.send(.searchUpdated(""), animation: .default)
      }
    } detail: {
      if let otpStore = store.scope(state: \.otp, action: \.otp) {
        OTPGeneratorWatchView(store: otpStore)
      }
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
