//
//  WatchRoot.swift
//
//
//  Created by Md. Rayhan Nabi on 22/3/24.
//

import Common
import Domain
import Foundation
import WatchHome

@Reducer
public struct WatchRoot {
  @ObservableState
  public struct State {
    var home: WatchHome.State?
    public init() {}
  }

  public enum Action {
    case home(WatchHome.Action)
    case onAppear
  }

  public init() {}

  public var body: some ReducerOf<WatchRoot> {
    Reduce<State, Action> { state, action in
      switch action {
      case .home:
        return .none
      case .onAppear:
        state.home = .init(entries: Entry.mocks)
        return .none
      }
    }
    .ifLet(\.home, action: \.home) {
      WatchHome()
    }
  }
}
