//
//  WatchHome.swift
//
//
//  Created by Md. Rayhan Nabi on 22/3/24.
//

import Common
import Domain
import Foundation

@Reducer
public struct WatchHome {
  @ObservableState
  public struct State {
    var entries: [Entry]
    var selectedEntry: Entry?
    var searchText = ""

    var filteredEntries: [Entry]

    public init(entries: [Entry]) {
      self.entries = entries
      self.filteredEntries = entries
      self.selectedEntry = selectedEntry ?? entries.first
    }
  }

  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case searchUpdated(String)
  }

  public init() {}

  public var body: some ReducerOf<WatchHome> {
    Reduce<State, Action> { state, action in
      switch action {
      case .binding:
        return .none
        
      case .searchUpdated(let text):
        state.searchText = text
        guard !state.searchText.isEmpty else {
          state.filteredEntries = state.entries
          return .none
        }
        state.filteredEntries = state.entries.filter { entry in
          entry.account.localizedCaseInsensitiveContains(state.searchText)
            || entry.issuer?.localizedCaseInsensitiveContains(state.searchText) ?? false
        }
        return .none
      }
    }
  }
}
