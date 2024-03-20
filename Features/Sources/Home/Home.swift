//
//  Home.swift
//
//
//  Created by Rayhan Nabi on 21/2/24.
//

import Common
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
    var searchState: HomeSearch.State

    var filteredEntries: [Entry] {
      if !searchState.isSearching || searchState.text.isEmpty {
        return entries
      }
      return entries.filter { entry in
        entry.account.localizedCaseInsensitiveContains(searchState.text)
          || entry.issuer?.localizedCaseInsensitiveContains(searchState.text) ?? false
      }
    }

    public init(entries: [Entry], selectedEntry: Entry? = nil) {
      self.entries = entries
      self.selectedEntry = selectedEntry ?? entries.first
      self.searchState = .init(showsSearch: !entries.isEmpty)
      if let entry = self.selectedEntry {
        self.otpState = .init(entry: entry)
      }
    }
  }

  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case selectEntry(Entry)
    case editEntry(Entry)
    case deleteEntry(Entry)
    case otpAction(OTPGenerator.Action)
    case searchAction(HomeSearch.Action)
  }

  public init() {}

  public var body: some ReducerOf<Home> {
    BindingReducer()
    Scope(state: \.searchState, action: \.searchAction) {
      HomeSearch()
    }
    Reduce<State, Action> { state, action in
      switch action {
      case .binding:
        return .none
      case .selectEntry(let entry):
        guard state.selectedEntry != entry else { return .none }
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
      case .otpAction:
        return .none
      case .searchAction(.toggleSearch(let isSearching)):
        return .send(.otpAction(.toggleCollapse(isSearching)))
      case .searchAction:
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
    return .merge(
      .send(.searchAction(.toggleSearch(false))),
      .send(.otpAction(.toggleCollapse(false))),
      .send(.otpAction(.startTimer))
    )
  }
}
