//
//  Home.swift
//
//
//  Created by Rayhan Nabi on 21/2/24.
//

import ComposableArchitecture
import Domain
import OTPGen
import SwiftUI

@Reducer
public struct Home {

  @ObservableState
  public struct State: Equatable {
    var entries: [Entry]
    var selectedEntry: Entry?
    var otpState: OTPGenerator.State?
    var searchState: SearchState = .init()

    var filteredEntries: [Entry] {
      if !searchState.isSearching || searchState.searchText.isEmpty {
        return entries
      }
      return entries.filter { entry in
        entry.account.localizedCaseInsensitiveContains(searchState.searchText)
          || entry.issuer?.localizedCaseInsensitiveContains(searchState.searchText) ?? false
      }
    }

    public init(entries: [Entry], selectedEntry: Entry? = nil) {
      self.entries = entries
      self.selectedEntry = selectedEntry ?? entries.first
      if let entry = self.selectedEntry {
        self.otpState = .init(entry: entry)
      }
    }
  }

  public struct SearchState: Equatable {
    var isSearching = false
    var isFocused = false
    var searchText = ""
  }

  public enum Action: Equatable, BindableAction {
    case selectEntry(Entry)
    case editEntry(Entry)
    case deleteEntry(Entry)
    case toggleSearch(Bool)
    case otpAction(OTPGenerator.Action)
    case binding(BindingAction<State>)
  }
  
  public init() {}

  public var body: some ReducerOf<Home> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .selectEntry(let entry):
        return updateEntrySelection(&state, entry: entry)
      case .editEntry(let entry):
        return .none
      case .deleteEntry(let entry):
        guard let indexToDelete = state.entries.firstIndex(of: entry) else { return .none }
        let indexToSelect =
          indexToDelete == state.entries.endIndex - 1 ? indexToDelete - 1 : indexToDelete + 1
        let nextEntry = state.entries[indexToSelect]
        state.entries.remove(at: indexToDelete)
        return updateEntrySelection(&state, entry: nextEntry)
      case .toggleSearch(let isSearching):
        state.searchState = .init(isSearching: isSearching, isFocused: isSearching)
        if isSearching {
          state.otpState = nil
        } else {
          if let entry = state.selectedEntry {
            return updateEntrySelection(&state, entry: entry)
          }
          return .send(.otpAction(.startTimer))
        }
        return .none
      case .otpAction:
        return .none
      case .binding(_):
        return .none
      }
    }
    .ifLet(\.otpState, action: \.otpAction) {
      OTPGenerator()
    }
  }

  private func updateEntrySelection(_ state: inout State, entry: Entry) -> Effect<Action> {
    state.selectedEntry = entry
    state.otpState = .init(entry: entry)
    state.searchState = .init()
    return .send(.otpAction(.startTimer))
  }
}
