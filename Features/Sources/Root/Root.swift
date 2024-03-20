//
//  Root.swift
//
//
//  Created by Rayhan Nabi on 10/2/24.
//

import Common
import Domain
import Home
import Settings
import SwiftUI

@Reducer
public struct Root {
  @ObservableState
  public struct State {
    var iCloudSyncEnabled = false
    var appearance: Appearance?
    var accentColor: Color?
    var home: Home.State?
    var path = StackState<Path.State>()

    public init() {}
  }

  public enum Action {
    case path(StackAction<Path.State, Path.Action>)
    case home(Home.Action)
    case onAppear
  }

  public init() {}

  @Dependency(\.appSettings) private var appSettings
  @Dependency(\.application) private var application

  public var body: some ReducerOf<Root> {
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        state.accentColor = appSettings.accentColor()
        state.appearance = appSettings.appearance()
        state.iCloudSyncEnabled = appSettings.iCloudSyncEnabled() ?? false
        state.home = .init(entries: Entry.mocks)
        return updateGlobalAppearance(state.appearance)

      case .home(.searchAction(.settingsTapped)):
        state.path.append(
          .settings(
            .init(
              icloudSyncEnabled: state.iCloudSyncEnabled,
              appearance: state.appearance ?? .system,
              accentColor: state.accentColor ?? Color.accentColor
            )
          )
        )
        return .none

      case .home:
        return .none

      case .path(let pathAction):
        guard case .element(id: _, action: let action) = pathAction else { return .none }
        return resolvePathAction(action, state: &state)
      }
    }
    .ifLet(\.home, action: \.home) {
      Home()
    }
    .forEach(\.path, action: \.path) {
      Path()
    }
  }

  private func resolvePathAction(_ action: Path.Action, state: inout State) -> Effect<Action> {
    switch action {
    case .settings(let action):
      return resolveSettingsAction(action, state: &state)
    }
  }

  private func resolveSettingsAction(
    _ action: Settings.Action,
    state: inout State
  ) -> Effect<Action> {
    switch action {
    case .update(.accentColorUpdated(let color)):
      state.accentColor = color
      appSettings.setAccentColor(color)
      return .none
    case .update(.appearanceUpdated(let appearance)):
      state.appearance = appearance
      appSettings.setAppearance(appearance)
      return updateGlobalAppearance(appearance)
    case .update(.iCloudSyncEnabled(let enabled)):
      state.iCloudSyncEnabled = enabled
      appSettings.setSyncEnabled(enabled)
      return .none
    case .update(.resetAppearanceTapped):
      state.accentColor = nil
      state.appearance = nil
      appSettings.setAppearance(nil)
      appSettings.setAccentColor(nil)
      return updateGlobalAppearance(nil)
    default:
      return .none
    }
  }

  func updateGlobalAppearance(_ appearance: Appearance?) -> Effect<Action> {
    .run { @MainActor _ in
      application.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .map(\.windows)
        .flatMap { $0 }
        .forEach { window in
          UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve) {
            window.overrideUserInterfaceStyle = appearance?.userInterfaceStyle ?? .unspecified
          }
        }
    }
  }
}

extension Root {
  @Reducer
  public struct Path {
    @ObservableState
    public enum State {
      case settings(Settings.State)
    }

    public enum Action {
      case settings(Settings.Action)
    }

    public var body: some ReducerOf<Path> {
      Scope(state: \.settings, action: \.settings) {
        Settings()
      }
    }
  }
}
