//
//  RootView.swift
//
//
//  Created by Rayhan Nabi on 10/2/24.
//

import Common
import Domain
import Home
import Settings
import SwiftUI

public struct RootView: View {
  @Bindable var store: StoreOf<Root>

  public init(store: StoreOf<Root>) {
    self.store = store
  }

  public var body: some View {
    NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
      ZStack {
        if let homeStore = store.scope(state: \.home, action: \.home) {
          HomeView(store: homeStore)
            .toolbar(.hidden)
        }
      }
    } destination: { targetStore in
      switch targetStore.state {
      case .settings:
        if let settingsStore = targetStore.scope(state: \.settings, action: \.settings) {
          SettingsView(store: settingsStore)
        }
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
    .tint(store.accentColor)
    .preferredColorScheme(store.appearance?.colorScheme)
  }
}
