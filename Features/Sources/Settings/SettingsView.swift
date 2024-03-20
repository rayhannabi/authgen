//
//  SettingsView.swift
//
//
//  Created by Md. Rayhan Nabi on 20/3/24.
//

import Common
import SwiftUI

public struct SettingsView: View {
  @Bindable var store: StoreOf<Settings>

  public init(store: StoreOf<Settings>) {
    self.store = store
  }

  public var body: some View {
    Form {
      Section("Sync") {
        Toggle(
          "Sync to iCloud",
          systemImage: "arrow.triangle.2.circlepath.icloud",
          isOn: $store.icloudSyncEnabled.sending(\.update.iCloudSyncEnabled)
        )
      }

      Section("Theme") {
        Picker(
          "Appearance",
          selection: $store.appearance.sending(\.update.appearanceUpdated).animation()
        ) {
          ForEach(Appearance.allCases) {
            Text($0.rawValue.capitalized)
          }
        }
        .pickerStyle(.menu)
        ColorPicker(
          "Accent color",
          selection: $store.accentColor.sending(\.update.accentColorUpdated).animation(),
          supportsOpacity: false
        )
        Button("Reset appearance") {
          store.send(.update(.resetAppearanceTapped), animation: .default)
        }
      }

      Section("Data & Privacy") {
        NavigationLink("Privacy policy") {
          Text("Lorem Ipsum Dolor Sit Amet")
        }
        Button("Import") {
          store.send(.importData)
        }
        Button("Export") {
          store.send(.exportData)
        }
        Button("Reset All Data", role: .destructive) {
          store.send(.resetData)
        }
      }

      Section("About") {
        LabeledContent("Version", value: store.version)
      }
    }
    .navigationTitle(Text("Settings"))
  }
}

#if DEBUG
  #Preview {
    NavigationStack {
      SettingsView(
        store: .init(
          initialState: Settings.State(
            icloudSyncEnabled: false,
            appearance: .system,
            accentColor: .accentColor
          ),
          reducer: Settings.init
        )
      )
    }
  }
#endif
