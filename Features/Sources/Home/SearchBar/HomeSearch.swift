//
//  HomeSearch.swift
//
//
//  Created by Rayhan Nabi on 19/3/24.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct HomeSearch {
  @ObservableState
  public struct State: Equatable {
    var showsSearchButton: Bool
    var isSearching = false
    var isFocused = false
    var text = ""
  }

  public enum Action: Equatable, BindableAction {
    case onAppear
    case toggleSearch(Bool)
    case binding(BindingAction<State>)
  }

  public var body: some ReducerOf<HomeSearch> {
    BindingReducer()
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        state.isFocused = true
        return .none
      case .toggleSearch(let isSearching):
        state.isSearching = isSearching
        state.isFocused = isSearching
        if !isSearching {
          state.text = ""
        }
        return .none
      case .binding:
        return .none
      }
    }
  }
}
