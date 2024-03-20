//
//  Color+Hex.swift
//
//
//  Created by Rayhan Nabi on 19/3/24.
//

import SwiftUI

#if canImport(UIKit)
  import UIKit
#elseif canImport(AppKit)
  import AppKit
#endif

#if canImport(UIKit)
  public typealias NativeColor = UIColor
#elseif canImport(AppKit)
  public typealias NativeColor = NSColor
#endif

extension Color {
  public init?(hex: String) {
    guard hex.hasPrefix("#") else { return nil }
    let hexString = String(hex.dropFirst())
    var rgba: UInt64 = 0
    let scanner = Scanner(string: hexString)
    guard scanner.scanHexInt64(&rgba) else { return nil }
    let r: UInt64
    let b: UInt64
    let g: UInt64
    let a: UInt64
    switch hexString.count {
    case 6:
      (r, g, b, a) = (rgba >> 16, rgba >> 8 & 0xFF, rgba & 0xFF, 0xFF)
    case 8:
      (r, g, b, a) = (rgba >> 24, rgba >> 16 & 0xFF, rgba >> 8 & 0xFF, rgba & 0xFF)
    default:
      assertionFailure("Invalid hex color \(hex)")
      return nil
    }
    self.init(
      red: Double(r) / 255,
      green: Double(g) / 255,
      blue: Double(b) / 255,
      opacity: Double(a) / 255
    )
  }

  public var hexValue: String {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    guard NativeColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
      assertionFailure("Could not convert color \(self)")
      return ""
    }
    let r = clamp(lroundl(red * 255), in: 0...255)
    let g = clamp(lroundl(green * 255), in: 0...255)
    let b = clamp(lroundl(blue * 255), in: 0...255)
    let a = clamp(lroundl(alpha * 255), in: 0...255)
    return String(format: "#%02X%02X%02X%02X", r, g, b, a)
  }
}
