//
//  EmptyContentView.swift
//
//
//  Created by Md. Rayhan Nabi on 22/3/24.
//

import SwiftUI

public struct EmptyContentView: View {
  let context: Context

  public init(context: Context) {
    self.context = context
  }

  public var body: some View {
    switch context {
    case .entries:
      ContentUnavailableView(
        "No Entry Yet",
        systemImage: "tray",
        description: Text("Tap on the + icon to add")
      )
    case .searchResults:
      ContentUnavailableView(
        "No Results Found",
        systemImage: "magnifyingglass",
        description: Text("Please try a different search")
      )
    }
  }
}

extension EmptyContentView {
  public enum Context {
    case entries
    case searchResults
  }
}
