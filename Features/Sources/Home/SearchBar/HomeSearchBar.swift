//
//  HomeSearchBar.swift
//
//
//  Created by Rayhan Nabi on 18/3/24.
//

import Common
import SwiftUI

struct HomeSearchBar: View {
  @Bindable var store: StoreOf<HomeSearch>
  @FocusState var isFocused: Bool
  var namespace: Namespace.ID

  init(store: StoreOf<HomeSearch>, isFocused: FocusState<Bool>, namespace: Namespace.ID) {
    self.store = store
    self.namespace = namespace
    _isFocused = isFocused
  }

  var body: some View {
    if store.isSearching {
      searchField
    } else {
      navigationView
    }
  }

  private var searchField: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .font(.title3)
        .matchedGeometryEffect(id: SearchBarID.search(), in: namespace)

      TextField("Search", text: $store.text)
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
        .focused($isFocused)

      Button {
        store.send(.toggleSearch(false), animation: .snappy)
      } label: {
        Image(systemName: "multiply")
          .font(.title3)
          .matchedGeometryEffect(id: SearchBarID.cancel(), in: namespace)
      }
      .buttonStyle(.plain)
    }
    .padding()
    .background()
    .clipShape(.capsule)
    .padding()
  }

  private var navigationView: some View {
    HStack {
      if store.showsSearch {
        Button {
          store.send(.toggleSearch(true), animation: .snappy)
        } label: {
          Image(systemName: "magnifyingglass")
            .matchedGeometryEffect(id: SearchBarID.search(), in: namespace)
        }
      }
      Spacer()
      Button {
        store.send(.settingsTapped)
      } label: {
        Image(systemName: "gearshape")
          .matchedGeometryEffect(id: SearchBarID.cancel(), in: namespace)
      }
    }
    .padding()
    .font(.title2)
    .buttonStyle(.plain)
  }
}
