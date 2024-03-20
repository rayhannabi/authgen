//
//  AuthgenApp.swift
//  Authgen
//
//  Created by Rayhan Nabi on 10/2/24.
//

import AuthgenKit

@main
struct AuthgenApp: App {
  let rootStore = StoreOf<Root>(initialState: Root.State(), reducer: Root.init)

  var body: some Scene {
    WindowGroup {
      RootView(store: rootStore)
    }
  }
}
