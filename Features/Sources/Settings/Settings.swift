//
//  Settings.swift
//
//
//  Created by Md. Rayhan Nabi on 20/3/24.
//

import Common
import SwiftUI

@Reducer
public struct Settings {
  @ObservableState
  public struct State {
    var icloudSyncEnabled: Bool
    var appearance: Appearance
    var accentColor: Color

    var version: String {
      guard
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")
          as? String,
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
          as? String
      else { return "" }
      return "\(version) (\(build))"
    }

    public init(icloudSyncEnabled: Bool, appearance: Appearance, accentColor: Color) {
      self.icloudSyncEnabled = icloudSyncEnabled
      self.appearance = appearance
      self.accentColor = accentColor
    }
  }

  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case update(SettingsUpdate)
    case importData
    case exportData
    case resetData

    @CasePathable
    public enum SettingsUpdate {
      case iCloudSyncEnabled(Bool)
      case appearanceUpdated(Appearance)
      case accentColorUpdated(Color)
      case resetAppearanceTapped
    }
  }

  public init() {}

  public var body: some ReducerOf<Settings> {
    BindingReducer()
    Reduce<State, Action> { state, action in
      switch action {
      case .binding:
        return .none
      case .update(.accentColorUpdated(let color)):
        state.accentColor = color
        return .none
      case .update(.appearanceUpdated(let appearance)):
        state.appearance = appearance
        return .none
      case .update(.iCloudSyncEnabled(let enabled)):
        state.icloudSyncEnabled = enabled
        return .none
      case .update(.resetAppearanceTapped):
        state.appearance = .system
        state.accentColor = .accentColor
        return .none
      case .importData:
        return .none
      case .exportData:
        return .none
      case .resetData:
        return .none
      }
    }
  }
}
