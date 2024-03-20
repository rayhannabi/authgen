//
//  Appearance.swift
//
//
//  Created by Md. Rayhan Nabi on 20/3/24.
//

import SwiftUI

public enum Appearance: String, Identifiable, CaseIterable {
  case system
  case dark
  case light

  public var id: Self { return self }
}

extension Appearance {
  public var colorScheme: ColorScheme? {
    switch self {
    case .system: nil
    case .dark: .dark
    case .light: .light
    }
  }

  public var userInterfaceStyle: UIUserInterfaceStyle {
    switch self {
    case .dark: .dark
    case .light: .light
    case .system: .unspecified
    }
  }

  var settingsKey: String? {
    switch self {
    case .system: nil
    default: rawValue
    }
  }
}
