//
//  SearchBarID.swift
//
//
//  Created by Rayhan Nabi on 19/3/24.
//

import Foundation

enum SearchBarID: String {
  case search
  case cancel

  func callAsFunction() -> String { rawValue }
}
