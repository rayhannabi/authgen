//
//  HomeSearchBar.swift
//
//
//  Created by Rayhan Nabi on 18/3/24.
//

import ComposableArchitecture
import SwiftUI

enum SearchBarMatchID: String {
  case searchIcon
  case cancelIcon

  func callAsFunction() -> String { rawValue }
}

//@Reducer
//struct HomeSearch {
//  @ObservableState
//  struct State {
//    var isSearching: Bool
//    var isFocused: Bool
//    var text: String
//  }
//
//  enum Action: BindableAction {
//    case toggleSearch(Bool)
//    case binding(BindingAction<State>)
//  }
//
//  var body: some ReducerOf<HomeSearch> {
//    BindingReducer()
//    Reduce<State, Action> { state, action in
//      switch action {
//      case .toggleSearch(let isSearching):
//        state.isSearching = isSearching
//        state.isFocused = isSearching
//        if !isSearching {
//          state.text = ""
//        }
//        return .none
//        
//      case .binding:
//        return .none
//      }
//    }
//  }
//}
//
//struct HomeSearchBarView: View {
//  @Bindable var store: StoreOf<HomeSearch>
//  @FocusState var isFocused: Bool
//  var namespace: Namespace.ID
//
//  init(store: StoreOf<HomeSearch>, namespace: Namespace.ID) {
//    self.store = store
//    self.namespace = namespace
//  }
//
//  var body: some View {
//    HStack {
//      Image(systemName: "magnifyingglass")
//        .font(.title3)
//        .matchedGeometryEffect(id: SearchBarMatchID.searchIcon(), in: namespace)
//
//      TextField("Search", text: $store.text)
//        .autocorrectionDisabled()
//        .textInputAutocapitalization(.never)
//        .focused($isFocused)
//
//      Button {
//        store.send(.toggleSearch(false))
//      } label: {
//        Image(systemName: "multiply")
//          .font(.title3)
//          .matchedGeometryEffect(id: SearchBarMatchID.cancelIcon(), in: namespace)
//      }
//      .buttonStyle(.plain)
//    }
//  }
//}

struct HomeSearchBar: View {
  @Binding var text: String
  @FocusState var isFocused: Bool
  var namespace: Namespace.ID
  let cancelAction: () -> Void

  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .font(.title3)
        .matchedGeometryEffect(id: SearchBarMatchID.searchIcon(), in: namespace)

      TextField("Search", text: $text)
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
        .focused($isFocused)

      Button(action: cancelAction) {
        Image(systemName: "multiply")
          .font(.title3)
          .matchedGeometryEffect(id: SearchBarMatchID.cancelIcon(), in: namespace)
      }
      .buttonStyle(.plain)
    }
    .padding()
    .background()
    .clipShape(.capsule)
    .padding()
  }
}
