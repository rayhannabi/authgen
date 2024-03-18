//
//  Root.swift
//
//
//  Created by Rayhan Nabi on 10/2/24.
//

import ComposableArchitecture
import Domain
import Foundation
import Home

@Reducer
public struct Root {
  
  @ObservableState
  public struct State {
    var homeState: Home.State?

    public init(homeState: Home.State? = nil) {
      self.homeState = homeState
    }
  }

  public enum Action {
    case homeAction(Home.Action)
    case onAppear
  }

  public init() {}

  public var body: some ReducerOf<Root> {
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        state.homeState = .init(entries: Entry.mocks)
        return .none
      case .homeAction:
        return .none
      }
    }
    .ifLet(\.homeState, action: \.homeAction) {
      Home()
    }
  }
}
