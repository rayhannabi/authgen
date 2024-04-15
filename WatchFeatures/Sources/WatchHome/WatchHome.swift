//
//  WatchHome.swift
//
//
//  Created by Md. Rayhan Nabi on 22/3/24.
//

import Common
import Domain
import Foundation
import OTPGenerator

@Reducer
public struct WatchHome {
  @ObservableState
  public struct State {
    var entries: [Entry]
    var filteredEntries: [Entry]
    var selectedEntry: Entry?
    var searchText = ""
    var otp: OTPGenerator.State?

    public init(entries: [Entry]) {
      self.entries = entries
      self.filteredEntries = entries
    }
  }

  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case searchUpdated(String)
    case entrySelected(Entry?)
    case otp(OTPGenerator.Action)
  }

  public init() {}

  public var body: some ReducerOf<WatchHome> {
    Reduce<State, Action> { state, action in
      switch action {
      case .binding:
        return .none

      case .entrySelected(let entry):
        state.selectedEntry = entry
        if let entry {
          state.otp = .init(entry: entry)
        }
        return .none

      case .otp:
        return .none

      case .searchUpdated(let text):
        state.searchText = text.trimmingCharacters(in: .whitespacesAndNewlines)
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
    .ifLet(\.otp, action: \.otp) {
      OTPGenerator()
    }
  }
}
