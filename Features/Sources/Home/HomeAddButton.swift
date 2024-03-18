//
//  HomeAddButton.swift
//
//
//  Created by Rayhan Nabi on 18/3/24.
//

import SwiftUI

struct HomeAddButton: View {
  let action: () -> Void
  let qrScanAction: () -> Void
  let manualEntryAction: () -> Void

  var body: some View {
    Button(action: action) {
      Image(systemName: "plus")
        .foregroundStyle(.background)
        .font(.title)
        .padding()
        .background(.primary)
        .clipShape(.rect(cornerRadius: 12))
        .shadow(color: .primary.opacity(0.3), radius: 16)
    }
    .buttonStyle(.plain)
    #if os(iOS)
      .contextMenu {
        Button("Scan QR code", systemImage: "qrcode.viewfinder", action: qrScanAction)
        Button("Add manually", systemImage: "pencil", action: manualEntryAction)
      }
    #endif
    .padding()
  }
}
