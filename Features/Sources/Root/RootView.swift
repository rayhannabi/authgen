//
//  RootView.swift
//
//
//  Created by Rayhan Nabi on 10/2/24.
//

import ComposableArchitecture
import Domain
import Home
import SwiftUI

public struct RootView: View {
  let store: StoreOf<Root>

  public init(store: StoreOf<Root>) {
    self.store = store
  }

  public var body: some View {
    ZStack {
      if let homeStore = store.scope(state: \.homeState, action: \.homeAction) {
        HomeView(store: homeStore)
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}
