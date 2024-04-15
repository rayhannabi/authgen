//
//  AuthgenWatchOSApp.swift
//  AuthgenWatchOS Watch App
//
//  Created by Md. Rayhan Nabi on 19/3/24.
//

import AuthgenWatchKit

@main
struct AuthgenWatchOSApp: App {
  let store = StoreOf<WatchRoot>(initialState: WatchRoot.State(), reducer: WatchRoot.init)

  var body: some Scene {
    WindowGroup {
      WatchRootView(store: store)
    }
  }
}
