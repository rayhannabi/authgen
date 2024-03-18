//
//  HomeNavigationBar.swift
//
//
//  Created by Rayhan Nabi on 18/3/24.
//

import SwiftUI

struct HomeNavigationBar: View {
  let showsSearch: Bool
  let namespace: Namespace.ID
  let searchAction: () -> Void
  let settingsAction: () -> Void

  var body: some View {
    HStack {
      if showsSearch {
        Button(action: searchAction) {
          Image(systemName: "magnifyingglass")
            .matchedGeometryEffect(id: SearchBarMatchID.searchIcon(), in: namespace)
        }
      }
      Spacer()
      Button(action: settingsAction) {
        Image(systemName: "gearshape")
          .matchedGeometryEffect(id: SearchBarMatchID.cancelIcon(), in: namespace)
      }
    }
    .padding()
    .font(.title2)
    .buttonStyle(.plain)
  }
}
