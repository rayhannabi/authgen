//
//  WatchRootView.swift
//
//
//  Created by Md. Rayhan Nabi on 22/3/24.
//

import Common
import SwiftUI
import WatchHome

public struct WatchRootView: View {
  let store: StoreOf<WatchRoot>

  public init(store: StoreOf<WatchRoot>) {
    self.store = store
  }

  public var body: some View {
    ZStack {
      if let homeStore = store.scope(state: \.home, action: \.home) {
        WatchHomeView(store: homeStore)
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}
