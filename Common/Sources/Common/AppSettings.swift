//
//  AppSettings.swift
//
//
//  Created by Md. Rayhan Nabi on 20/3/24.
//

import Dependencies
import DependenciesMacros
import SwiftUI
import Utilities

@DependencyClient
public struct AppSettings {
  public var iCloudSyncEnabled: () -> Bool?
  public var appearance: () -> Appearance?
  public var accentColor: () -> Color?
  public var setSyncEnabled: (Bool?) -> Void
  public var setAppearance: (Appearance?) -> Void
  public var setAccentColor: (Color?) -> Void
}

extension AppSettings {
  public enum Key: String {
    case iCloudSyncEnabled
    case appearance
    case accentColor

    public func callAsFunction() -> String { rawValue }
  }
}

extension AppSettings: DependencyKey {
  public static var liveValue: AppSettings {
    @Dependency(\.userDefaults) var userDefaults
    return .init {
      userDefaults.bool(forKey: Key.iCloudSyncEnabled())
    } appearance: {
      guard let value = userDefaults.string(forKey: Key.appearance()),
        let appearance = Appearance(rawValue: value)
      else { return .system }
      return appearance
    } accentColor: {
      guard let value = userDefaults.string(forKey: Key.accentColor()),
        let color = Color(hex: value)
      else { return nil }
      return color
    } setSyncEnabled: { enabled in
      userDefaults.set(enabled, forKey: Key.iCloudSyncEnabled())
    } setAppearance: { appearance in
      userDefaults.set(appearance?.settingsKey, forKey: Key.appearance())
    } setAccentColor: { color in
      userDefaults.set(color?.hexValue, forKey: Key.accentColor())
    }

  }
}

extension DependencyValues {
  public var appSettings: AppSettings {
    get { self[AppSettings.self] }
    set { self[AppSettings.self] = newValue }
  }
}
