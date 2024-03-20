//
//  ColorTests.swift
//
//
//  Created by Rayhan Nabi on 20/3/24.
//

import SwiftUI
import XCTest

@testable import Utilities

class ColorTests: XCTestCase {
  func test24BitColorHexInit() {
    let hex = "#ffffff"
    let color = Color(hex: hex)
    XCTAssertNotNil(color)
    XCTAssertEqual(color, Color.white)
    XCTAssertEqual(NativeColor(color!).cgColor.alpha, 1)
  }
  
  func test32BitColorHexInit() {
    let hex = "#ffffffff"
    let color = Color(hex: hex)
    XCTAssertNotNil(color)
    XCTAssertEqual(color, Color.white)
    XCTAssertEqual(NativeColor(color!).cgColor.alpha, 1)
  }
  
  func test32BitColorHexAlphaChannel() {
    let hex = "#ffffff33"
    let color = Color(hex: hex)
    XCTAssertNotNil(color)
    let alpha = (NativeColor(color!).cgColor.alpha * 10).rounded() / 10
    XCTAssertEqual(alpha, 0.2)
  }
  
  func testColorHexValue() {
    let color = Color.white.opacity(0.5)
    XCTAssertEqual(color.hexValue, "#FFFFFF80")
  }
  
  func testColorHexDerivation() {
    let color = Color(red: 1, green: 0, blue: 1, opacity: 0.8)
    let colorHex = "#FF00FFCC"
    let derivedColor = Color(hex: colorHex)
    let derivedHex = color.hexValue
    XCTAssertNotNil(derivedColor)
    XCTAssertEqual(color, derivedColor)
    XCTAssertEqual(colorHex, derivedHex)
  }
}
