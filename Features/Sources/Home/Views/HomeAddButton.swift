//
//  HomeAddButton.swift
//
//
//  Created by Rayhan Nabi on 18/3/24.
//

import Common
import SwiftUI

struct HomeAddButton: View {
  let action: () -> Void
  let manualEntryAction: () -> Void

  var body: some View {
    Button(action: action) {
      Image(systemName: "plus")
        .foregroundStyle(.background)
        .font(.title)
        .shadow(radius: 8)
        .padding()
        .background(.tint)
        .clipShape(.rect(cornerRadius: 12))
        .shadow(color: .primary.opacity(0.3), radius: 16)
    }
    .buttonStyle(.plain)
    #if os(iOS)
      .contextMenu {
        Button("Scan QR code", systemImage: "qrcode.viewfinder", action: action)
        Button("Add manually", systemImage: "pencil", action: manualEntryAction)
      }
    #endif
    .padding()
  }
}

#if DEBUG
  #Preview {
    HomeAddButton(action: {}, manualEntryAction: {})
  }
#endif
