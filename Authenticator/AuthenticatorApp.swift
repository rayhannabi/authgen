//
//  AuthenticatorApp.swift
//  Authenticator
//
//  Created by Rayhan Nabi on 10/2/24.
//

import AuthenticatorKit

@main
struct AuthenticatorApp: App {
  let rootStore = StoreOf<Root>(initialState: Root.State(), reducer: Root.init)

  var body: some Scene {
    WindowGroup {
      RootView(store: rootStore)
    }
  }
}
