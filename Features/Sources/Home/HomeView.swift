//
//  HomeView.swift
//
//
//  Created by Rayhan Nabi on 21/2/24.
//

import ComposableArchitecture
import Domain
import OTPGen
import SwiftUI
import Utilities

public struct HomeView: View {
  @Bindable var store: StoreOf<Home>
  @FocusState var isFocused
  @Namespace var namespace

  public init(store: StoreOf<Home>) {
    self.store = store
  }

  public var body: some View {
    ZStack {
      if store.filteredEntries.isEmpty {
        if store.searchState.isSearching {
          noSearchResultsView
        } else {
          noEntriesView
        }
      } else {
        entriesView
      }
      addButton
    }
    .contentMargins(16, for: .scrollContent)
    .safeAreaInset(edge: .top) {
      let isSearching = store.searchState.isSearching
      Group {
        if isSearching {
          HomeSearchBar(
            text: $store.searchState.searchText,
            isFocused: _isFocused,
            namespace: namespace
          ) {
            store.send(.toggleSearch(false), animation: .snappy)
          }
        } else {
          ZStack(alignment: .top) {
            codeView
            HomeNavigationBar(showsSearch: !store.entries.isEmpty, namespace: namespace) {
              store.send(.toggleSearch(true), animation: .snappy)
            } settingsAction: {
              // TODO: open app settings
            }
          }
        }
      }
      .background {
        VStack(spacing: 0) {
          Rectangle()
            .fill(.thickMaterial)
            .background {
              AsyncImage(url: store.selectedEntry?.iconURL) { image in
                image
                  .resizable()
                  .blur(radius: 80)
                  .clipped()
              } placeholder: {
                EmptyView()
              }
            }
            .ignoresSafeArea()
          Divider()
        }
      }
    }
    .syncFocusState($isFocused, with: $store.searchState.isFocused)
  }
}

extension HomeView {
  private var codeView: some View {
    VStack {
      if let store = store.scope(state: \.otpState, action: \.otpAction),
        !self.store.searchState.isSearching
      {
        OTPGeneratorView(store: store)
          .padding(.top, 6)
      }
    }
    .frame(maxWidth: .infinity)
  }

  private var entriesView: some View {
    ScrollView {
      ForEach(store.filteredEntries) { entry in
        HomeEntryView(entry: entry, searchText: $store.searchState.searchText) { currentEntry in
          store.send(.selectEntry(currentEntry), animation: .default)
        } editAction: { currentEntry in
          store.send(.editEntry(currentEntry))
        } deleteAction: { currentEntry in
          store.send(.deleteEntry(currentEntry))
        }
      }
    }
  }

  private var addButton: some View {
    ZStack {
      VStack {
        Spacer()
        HStack {
          Spacer()
          HomeAddButton {

          } qrScanAction: {

          } manualEntryAction: {

          }
        }
      }
    }
  }

  private var noEntriesView: some View {
    ContentUnavailableView(
      "No Entry Yet",
      systemImage: "tray",
      description: Text("Tap on the + icon to add")
    )
  }

  private var noSearchResultsView: some View {
    ContentUnavailableView(
      "No Results Found",
      systemImage: "magnifyingglass",
      description: Text("Please try a different search")
    )
  }
}

#if DEBUG
  #Preview {
    HomeView(store: .init(initialState: Home.State(entries: Entry.mocks), reducer: Home.init))
  }
#endif
