//
//  AppColor.swift
//
//
//  Created by Md. Rayhan Nabi on 28/3/24.
//

import SwiftUI

public enum AppColor {
  public static var all: [Color] {
    [
      .black, .red, .green, .blue, .yellow, .orange,
      .mint, .cyan, .purple, .teal, .pink, .indigo,
    ]
  }

  public static var random: Color {
    all.randomElement() ?? .black
  }
}
