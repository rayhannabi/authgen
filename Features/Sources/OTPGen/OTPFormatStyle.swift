//
//  OTPFormatStyle.swift
//
//
//  Created by Rayhan Nabi on 22/2/24.
//

import Foundation

struct OTPFormatStyle: FormatStyle {
  typealias FormatInput = String
  typealias FormatOutput = String

  func format(_ value: String) -> String {
    guard value.count > 4, value.count % 2 == 0 else { return value }
    let grouping =
      switch value.count {
      case 6: 3
      default: 2
      }
    return value.chunks(of: grouping).joined(separator: " ")
  }
}

extension FormatStyle where Self == OTPFormatStyle {
  static var oneTimePassword: OTPFormatStyle { .init() }
}

extension String {
  fileprivate func chunks(of length: Int) -> [String] {
    stride(from: 0, to: count, by: length)
      .map {
        let start = index(startIndex, offsetBy: $0)
        let end = index(start, offsetBy: length, limitedBy: endIndex) ?? endIndex
        return String(self[start..<end])
      }
  }
}
