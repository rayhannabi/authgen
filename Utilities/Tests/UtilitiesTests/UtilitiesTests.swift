// 
//  UtilitiesTests.swift
//  
//
//  Created by Rayhan Nabi on 20/3/24.
//

import XCTest

@testable import Utilities

class UtilitiesTests: XCTestCase {
  func testClamp() {
    var value = 0.6
    let range = 0.0...1.0
    XCTAssertEqual(clamp(value, in: range), value)
    value = -1
    XCTAssertEqual(clamp(value, in: range), 0)
    value = 1.00009
    XCTAssertEqual(clamp(value, in: range), 1)
  }
}
